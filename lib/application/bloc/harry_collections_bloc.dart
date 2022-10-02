import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/elixir.dart';
import '../../data/models/house.dart';
import '../../data/repositories/wizard_world_repository.dart';
import '../injection_module/injection_container.dart';

part 'harry_collections_bloc.freezed.dart';
part 'harry_collections_event.dart';
part 'harry_collections_state.dart';

class HarryCollectionsBloc extends Bloc<HarryCollectionsEvent, HarryCollectionsState> {
  final WizardWorldRepository wizardWorldRepository = sl<WizardWorldRepository>();

  HarryCollectionsBloc() : super(const _Initial()) {
    on<_Bootstrap>(_onBootstrap);
    on<_PullElixirs>(_onPullElixirs);
  }

  Future<void> _onBootstrap(_Bootstrap event, Emitter<HarryCollectionsState> emit) async {
    emit(const HarryCollectionsState.loading());
    try {
      final List<List<dynamic>> result = await Future.wait([
        wizardWorldRepository.fetchElixirs(lastId: null, count: 20),
        wizardWorldRepository.fetchAllHouses(),
      ]);
      final elixirs = result[0] as List<Elixir>;
      final houses = result[1] as List<House>;

      emit(HarryCollectionsState.loaded(
        elixirs: elixirs,
        houses: houses,
      ));
    } on DioError catch (e) {
      emit(HarryCollectionsState.error('Network error: ${e.message}'));
    } catch (e) {
      emit(HarryCollectionsState.error('System error: $e'));
    }
  }

  Future<void> _onPullElixirs(_PullElixirs event, Emitter<HarryCollectionsState> emit) async {
    final count = event.count;
    final lastId = event.lastId;
    try {
      final List<Elixir> newElixirs = await wizardWorldRepository.fetchElixirs(lastId: lastId, count: count);
      final newState = state.maybeMap(
        loaded: (innerState) {
          return innerState.copyWith(elixirs: [...innerState.elixirs, ...newElixirs]);
        },
        orElse: () => state,
      );
      emit(newState);
    } on DioError catch (e) {
      emit(HarryCollectionsState.error('Network error: ${e.message}'));
    } catch (e) {
      emit(HarryCollectionsState.error('System error: $e'));
    }
  }
}
