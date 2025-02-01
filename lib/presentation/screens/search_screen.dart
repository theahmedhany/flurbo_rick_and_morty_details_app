import '../widgets/custom_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../business_logic/cubit/characters_state.dart';
import '../../data/models/characters_model.dart';
import '../../constants/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Results> allCharacters;
  late List<Results> searchedForCharacters;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allCharacters = [];
    searchedForCharacters = [];
    BlocProvider.of<CharactersCubit>(context).emitGetAllCharacters();
  }

  void addSearchedItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where(
          (character) => character.name!.toLowerCase().contains(
                searchedCharacter.toLowerCase(),
              ),
        )
        .toList();
    setState(() {});
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
      searchedForCharacters = [];
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState<List<Results>>>(
      builder: (context, state) {
        return state.when(
          idle: () => const Center(child: Text('Idle')),
          loading: () => CustomLoadingIndicator(),
          success: (characters) {
            allCharacters = characters;
            return buildLoadedListWidgets();
          },
          error: (error) => Center(
            child: Text('Error: ${error.toString()}'),
          ),
        );
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchTextController,
                    onChanged: (searchedCharacter) {
                      if (searchedCharacter.isEmpty) {
                        setState(() {
                          searchedForCharacters = [];
                        });
                      } else {
                        addSearchedItemsToSearchedList(searchedCharacter);
                      }
                    },
                    cursorColor: AppColors.kPrimaryColor,
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search for a character...',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      hintStyle: TextStyle(
                        color: AppColors.kSecondaryColor,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          width: 3,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          width: 3,
                          color: AppColors.kSecondaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          width: 3,
                          color: AppColors.kSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _searchTextController.text.isNotEmpty
              ? buildCharactersList()
              : Center(
                  child: Column(
                    children: [
                      SizedBox(height: 140),
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: Image.asset(
                          'assets/images/search.gif',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Start searching now!',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildCharactersList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchedForCharacters.length,
      itemBuilder: (ctx, index) {
        return SearchedCharacterItem(
          character: searchedForCharacters[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kMainBackground,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.kMainBackground,
        leading: IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.kPrimaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Search',
          style: TextStyle(
            color: AppColors.kPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: buildBlocWidget(), // Removed OfflineBuilder
    );
  }
}

class SearchedCharacterItem extends StatelessWidget {
  final Results character;

  const SearchedCharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => Navigator.pushNamed(
        context,
        characterDetailsScreen,
        arguments: character,
      ),
      child: Container(
        width: double.infinity,
        height: 160,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Hero(
              tag: character.id ?? 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.kSecondaryColor,
                    width: 3,
                  ),
                ),
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kFourthColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: character.image?.isNotEmpty ?? false
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: 'assets/images/loading.gif',
                            placeholderFit: BoxFit.contain,
                            image: character.image ??
                                'https://i.guim.co.uk/img/media/4813cbd33a983ef90f162454aae9b040d29cb68b/82_0_1800_1080/master/1800.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=684b052f7778d7a15ef13cafaf1d9852',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/placeholder.jpg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Text(
                    character.name ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 22,
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 4),
                  Text(
                    character.species ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.kSecondaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 86,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColors.kFourthColor.withValues(alpha: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            character.gender ?? 'Unknown',
                            style: TextStyle(
                              color: AppColors.kSecondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 86,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColors.kFourthColor.withValues(alpha: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            character.status ?? 'Unknown',
                            style: TextStyle(
                              color: AppColors.kSecondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.pie_chart_rounded,
                        size: 22,
                        color: AppColors.kSecondaryColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Episodes: ${character.episode?.length.toString() ?? 'Unknown'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
