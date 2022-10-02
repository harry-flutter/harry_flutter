part of 'harry_collections_bloc.dart';

@freezed
class HarryCollectionsEvent with _$HarryCollectionsEvent {
  const factory HarryCollectionsEvent.bootstrap() = _Bootstrap;
  const factory HarryCollectionsEvent.pullElixirs({String? lastId, required int count}) = _PullElixirs;
}
