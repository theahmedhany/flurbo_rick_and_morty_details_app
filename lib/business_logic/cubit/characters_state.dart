import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants/network_exceptions.dart';

part 'characters_state.freezed.dart';

@freezed
class CharactersState<T> with _$CharactersState<T> {
  const factory CharactersState.idle() = Idle<T>;

  const factory CharactersState.loading() = Loading<T>;

  const factory CharactersState.success(T data) = Success<T>;

  const factory CharactersState.error(NetworkExceptions networkExceptions) =
      Error<T>;
}
