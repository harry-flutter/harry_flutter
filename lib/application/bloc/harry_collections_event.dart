part of 'harry_collections_bloc.dart';

enum SortOrderTypes {
  asc,
  desc,
}

@freezed
class HarryCollectionsEvent with _$HarryCollectionsEvent {
  const factory HarryCollectionsEvent.init() = _Init;
  const factory HarryCollectionsEvent.pullElixirs({
    String? lastId,
    required int count,
    required SortOrderTypes orderType,
  }) = _PullElixirs;
}
