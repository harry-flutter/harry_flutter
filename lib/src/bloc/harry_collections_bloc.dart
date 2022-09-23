import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/elixir.dart';
import '../repository/wizard_world_repository.dart';

part 'harry_collections_event.dart';
part 'harry_collections_state.dart';
part 'harry_collections_bloc.freezed.dart';

class HarryCollectionsBloc extends Bloc<HarryCollectionsEvent, HarryCollectionsState> {
  final WizardWorldRepository wizardWorldRepository;

  HarryCollectionsBloc({required this.wizardWorldRepository}) : super(const _Initial()) {
    on<_Bootstrap>(_onBootstrap);
  }

  Future<void> _onBootstrap(_Bootstrap event, Emitter<HarryCollectionsState> emit) async {
    emit(const HarryCollectionsState.loading());
    try {
      final elixirs = await wizardWorldRepository.getElixirs();
      emit(HarryCollectionsState.loaded(elixirs));
    } on DioError catch (e) {
      emit(HarryCollectionsState.error('Network error: ${e.message}'));
    } catch (e) {
      emit(HarryCollectionsState.error('System error: $e'));
    }
  }
}
