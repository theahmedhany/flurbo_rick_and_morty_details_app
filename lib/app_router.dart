import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/characters_model.dart';
import 'presentation/screens/character_details_screen.dart';
import 'presentation/screens/characters_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/search_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<CharactersCubit>(_),
            child: const HomeScreen(),
          ),
        );

      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<CharactersCubit>(_),
            child: const CharactersScreen(),
          ),
        );

      case searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<CharactersCubit>(_),
            child: const SearchScreen(),
          ),
        );

      case characterDetailsScreen:
        final selectedCharacter = settings.arguments as Results;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<CharactersCubit>(_),
            child: CharacterDetailsScreen(
              character: selectedCharacter,
            ),
          ),
        );

      default:
        return null;
    }
  }
}
