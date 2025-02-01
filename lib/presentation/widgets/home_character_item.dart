import 'package:flutter/material.dart';

import '../../constants/strings.dart';
import '../../data/models/characters_model.dart';

class HomeCharacterItem extends StatelessWidget {
  final Results character;

  const HomeCharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          characterDetailsScreen,
          arguments: character,
        ),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black54,
            ),
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name ?? 'Unknown',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.id ?? 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
              ),
              child: character.image?.isNotEmpty ?? false
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image ??
                          'https://i.guim.co.uk/img/media/4813cbd33a983ef90f162454aae9b040d29cb68b/82_0_1800_1080/master/1800.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=684b052f7778d7a15ef13cafaf1d9852',
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
