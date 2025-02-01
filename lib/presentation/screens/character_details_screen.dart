import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';
import '../../data/models/characters_model.dart';
import '../../data/models/quotes.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Results character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kMainBackground,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          _buildSliverList(),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          'assets/images/arrow.svg',
          width: 34,
          colorFilter:
              ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn),
        ),
      ),
      scrolledUnderElevation: 0,
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.kMainBackground,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name ?? 'Unknown',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.kPrimaryColor,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 50,
                color: AppColors.kThirdColor.withValues(alpha: 0.7),
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        background: Hero(
          tag: character.id ?? 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
            child: character.image != null && character.image!.isNotEmpty
                ? Image.network(
                    character.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/placeholder.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }

  SliverList _buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rick and Morty',
                      style: TextStyle(
                        color: AppColors.kSecondaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.bookmark_border_rounded,
                      color: AppColors.kPrimaryColor,
                      size: 28,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pie_chart_rounded,
                          size: 22,
                          color: AppColors.kSecondaryColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Episodes: ${character.episode?.length.toString() ?? 'Unknown'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 46),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          size: 24,
                          color: AppColors.kSecondaryColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '9.1 (IMDP)',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: AppColors.kThirdColor),
                SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created Date',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kSecondaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          character.created!.substring(0, 10),
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 46),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Genre',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kSecondaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 86,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: AppColors.kFourthColor
                                    .withValues(alpha: 0.5),
                              ),
                              child: Center(
                                child: Text(
                                  'Sitcom',
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
                                color: AppColors.kFourthColor
                                    .withValues(alpha: 0.5),
                              ),
                              child: Center(
                                child: Text(
                                  'Comedy',
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
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Divider(color: AppColors.kThirdColor),
                SizedBox(height: 14),
                _buildCharacterInfo(
                    'Species: ', character.species ?? 'Unknown'),
                _buildDivider(314),
                _buildCharacterInfo('Status: ', character.status ?? 'Unknown'),
                _buildDivider(325),
                _buildCharacterInfo('Gender: ', character.gender ?? 'Unknown'),
                _buildDivider(317),
                _buildCharacterInfo(
                    'Origin: ', character.origin?.name ?? 'Unknown'),
                _buildDivider(326),
                _buildCharacterInfo(
                    'Location: ', character.location?.name ?? 'Unknown'),
                _buildDivider(305),
                _buildCharacterInfo(
                    'Type: ',
                    character.type == null || character.type!.isEmpty
                        ? 'Unknown'
                        : character.type!),
                _buildDivider(337),
                SizedBox(height: 10),
                Divider(color: AppColors.kThirdColor),
                SizedBox(height: 24),
                _buildQuotesSection(),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildCharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColors.kSecondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.kSecondaryColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: AppColors.kPrimaryColor,
      thickness: 2,
    );
  }

  Widget _buildQuotesSection() {
    final randomQuoteIndex = Random().nextInt(Quotes.rickAndMortyQuotes.length);
    final randomQuote = Quotes.rickAndMortyQuotes[randomQuoteIndex];

    return Center(
      child: SizedBox(
        height: 130,
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: AppColors.kPrimaryColor,
            shadows: [
              Shadow(
                blurRadius: 12,
                color: AppColors.kThirdColor,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(randomQuote),
            ],
          ),
        ),
      ),
    );
  }
}
