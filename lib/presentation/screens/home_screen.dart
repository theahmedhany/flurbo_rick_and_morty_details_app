import '../../business_logic/cubit/characters_cubit.dart';
import '../../business_logic/cubit/characters_state.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../data/models/characters_model.dart';
import '../widgets/custom_loading_indicator.dart';
import '../widgets/movie_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            return HomeScreenBody(
              allCharacters: allCharacters,
            );
          },
          error: (error) => Center(
            child: Text('Error: ${error.toString()}'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kMainBackground,
      body: buildBlocWidget(), // Removed OfflineBuilder
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key, required this.allCharacters});

  final List allCharacters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Spacer(),
                        CupertinoButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              searchScreen,
                            );
                          },
                          padding: EdgeInsets.zero,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color:
                                  AppColors.kFourthColor.withValues(alpha: 0.5),
                            ),
                            child: Icon(
                              Icons.search,
                              size: 32,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/wallpaper.jpg'),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                          AppColors.kSecondaryColor.withValues(alpha: 0.3),
                          BlendMode.srcOver,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Characters',
                          style: TextStyle(
                            color: AppColors.kSecondaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        CupertinoButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              charactersScreen,
                            );
                          },
                          padding: EdgeInsets.zero,
                          child: Container(
                            width: 94,
                            height: 34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: AppColors.kFourthColor,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  color: AppColors.kFourthColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MovieCarousel(
                    allCharacters: allCharacters,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
