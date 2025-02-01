import 'package:dio/dio.dart';
import '../../constants/strings.dart';
import '../models/characters_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'characters_web_services.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CharactersWebServices {
  factory CharactersWebServices(Dio dio, {String? baseUrl}) =
      _CharactersWebServices;

  @GET('character')
  Future<CharactersModel> getAllCharacters();
}
