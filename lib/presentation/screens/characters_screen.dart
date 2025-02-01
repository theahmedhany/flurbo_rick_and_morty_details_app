import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../business_logic/cubit/characters_state.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../data/models/characters_model.dart';
import '../widgets/custom_loading_indicator.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Results> allCharacters;

  @override
  void initState() {
    super.initState();
    allCharacters = [];
    BlocProvider.of<CharactersCubit>(context).emitGetAllCharacters();
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
          buildCharactersList(),
        ],
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character: allCharacters[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kMainBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.kPrimaryColor,
          ),
        ),
        backgroundColor: AppColors.kMainBackground,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'All Characters',
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

class CharacterItem extends StatelessWidget {
  final Results character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.kMainBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.kSecondaryColor,
          width: 3,
        ),
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          characterDetailsScreen,
          arguments: character,
        ),
        child: GridTile(
          child: Hero(
            tag: character.id ?? 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  character.image?.isNotEmpty ?? false
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
                          fit: BoxFit.cover,
                        ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color:
                                AppColors.kFourthColor.withValues(alpha: 0.7),
                          ),
                          child: Text(
                            character.name ?? 'Unknown',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
