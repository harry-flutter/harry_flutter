import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/elixir.dart';
import '../../data/models/house.dart';
import '../../data/repository/wizard_world_repository.dart';
import '../injection_module/injection_container.dart';

part 'harry_collections_bloc.freezed.dart';
part 'harry_collections_event.dart';
part 'harry_collections_state.dart';

class HarryCollectionsBloc extends Bloc<HarryCollectionsEvent, HarryCollectionsState> {
  final WizardWorldRepository wizardWorldRepository = sl<WizardWorldRepository>();

  HarryCollectionsBloc() : super(const _Initial()) {
    on<_Bootstrap>(_onBootstrap);
  }

  Future<void> _onBootstrap(_Bootstrap event, Emitter<HarryCollectionsState> emit) async {
    emit(const HarryCollectionsState.loading());
    try {
      final elixirs = await wizardWorldRepository.fetchAllElixirs();
      final houses = await wizardWorldRepository.fetchAllHouses();
      emit(HarryCollectionsState.loaded(elixirs: elixirs, houses: houses));
    } on DioError catch (e) {
      emit(HarryCollectionsState.error('Network error: ${e.message}'));
    } catch (e) {
      emit(HarryCollectionsState.error('System error: $e'));
    }
  }
}
