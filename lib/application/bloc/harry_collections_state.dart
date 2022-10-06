part of 'harry_collections_bloc.dart';

@freezed
class HarryCollectionsState with _$HarryCollectionsState {
  const factory HarryCollectionsState.initial() = _Initial;
  const factory HarryCollectionsState.loading() = _Loading;
  const factory HarryCollectionsState.loaded({
    @Default([]) List<Elixir> elixirs,
    @Default([]) List<House> houses,
    @Default(SortOrderTypes.asc) SortOrderTypes orderType,
  }) = _Loaded;
  const factory HarryCollectionsState.error(String msg) = _Error;
}
