import 'package:animations/animations.dart';
import '../screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/models/characters_model.dart';

class MovieCard extends StatelessWidget {
  final Results character;

  const MovieCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        closedBuilder: (context, action) => buildMovieCard(context),
        openBuilder: (context, action) =>
            CharacterDetailsScreen(character: character),
      ),
    );
  }

  Column buildMovieCard(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.kMainBackground,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: AppColors.kSecondaryColor,
                width: 3,
              ),
            ),
            child: Hero(
              tag: character.id ?? 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
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
                            margin: EdgeInsets.all(14),
                            padding: EdgeInsets.symmetric(
                              horizontal: 34,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color:
                                  AppColors.kFourthColor.withValues(alpha: 0.5),
                            ),
                            child: Text(
                              character.name ?? 'Unknown',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
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
      ],
    );
  }
}
