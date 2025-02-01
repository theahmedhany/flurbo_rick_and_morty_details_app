// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import '../../constants/network_exceptions.dart';
import '../../data/models/characters_model.dart';
import '../../data/repos/characters_repo.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState<List<Results>>> {
  final CharactersRepo charactersRepo;

  CharactersCubit(this.charactersRepo) : super(const CharactersState.idle());

  void emitGetAllCharacters() async {
    emit(const CharactersState.loading());

    try {
      final result = await charactersRepo.getAllCharacters();
      result.when(
        success: (List<Results> characters) {
          emit(CharactersState.success(characters));
        },
        failure: (NetworkExceptions error) {
          emit(CharactersState.error(error));
        },
      );
    } catch (e) {
      emit(CharactersState.error(NetworkExceptions.getDioException(e)));
    }
  }
}
