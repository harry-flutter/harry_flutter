part of 'harry_collections_bloc.dart';

@freezed
class HarryCollectionsState with _$HarryCollectionsState {
  const factory HarryCollectionsState.initial() = _Initial;
  const factory HarryCollectionsState.loading() = _Loading;
  const factory HarryCollectionsState.loaded({
    @Default([]) List<Elixir> elixirs,
    @Default(SortOrderTypes.asc) SortOrderTypes elixirsOrderType,
    @Default([]) List<House> houses,
    @Default([]) List<Ingredient> ingredients,
    @Default([]) List<Wizard> wizards,
  }) = _Loaded;
  const factory HarryCollectionsState.error(String msg) = _Error;
}
