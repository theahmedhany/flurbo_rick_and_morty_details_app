import '../../constants/network_exceptions.dart';
import '../api/api_result.dart';
import '../api/characters_web_services.dart';
import '../models/characters_model.dart';

class CharactersRepo {
  final CharactersWebServices charactersWebServices;

  CharactersRepo(this.charactersWebServices);

  Future<ApiResult<List<Results>>> getAllCharacters() async {
    try {
      final CharactersModel response =
          await charactersWebServices.getAllCharacters();

      final List<Results> characters = response.results ?? [];

      return ApiResult.success(characters);
    } catch (error) {
      return ApiResult.failure(NetworkExceptions.getDioException(error));
    }
  }
}
