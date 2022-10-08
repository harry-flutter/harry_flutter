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
    on<_Init>(_onInit);
    on<_PullElixirs>(_onPullElixirs);
  }

  Future<void> _onInit(_Init event, Emitter<HarryCollectionsState> emit) async {
    const initialOrderType = SortOrderTypes.asc;

    emit(const HarryCollectionsState.loading());

    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      final List<List<dynamic>> result = await Future.wait([
        wizardWorldRepository.fetchElixirs(lastId: null, count: 20, orderType: initialOrderType),
        wizardWorldRepository.fetchAllHouses(),
      ]);
      final elixirs = result[0] as List<Elixir>;
      final houses = result[1] as List<House>;

      emit(HarryCollectionsState.loaded(
        elixirs: elixirs,
        houses: houses,
        orderType: initialOrderType,
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
    final orderType = event.orderType;

    try {
      final List<Elixir> newElixirs = await wizardWorldRepository.fetchElixirs(
        lastId: lastId,
        count: count,
        orderType: orderType,
      );

      final newState = state.maybeMap(
        loaded: (innerState) {
          if (innerState.orderType == orderType) {
            return innerState.copyWith(elixirs: [...innerState.elixirs, ...newElixirs]);
          } else {
            return innerState.copyWith(elixirs: [...newElixirs], orderType: orderType);
          }
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
