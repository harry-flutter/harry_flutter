part of 'harry_collections_bloc.dart';

@freezed
class HarryCollectionsState with _$HarryCollectionsState {
  const factory HarryCollectionsState.initial() = _Initial;
  const factory HarryCollectionsState.loading() = _Loading;
  const factory HarryCollectionsState.loaded(List<Elixir> data) = _Loaded;
  const factory HarryCollectionsState.error(String msg) = _Error;
}
