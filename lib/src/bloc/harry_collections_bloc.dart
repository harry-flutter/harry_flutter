import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/elixir.dart';

part 'harry_collections_event.dart';
part 'harry_collections_state.dart';
part 'harry_collections_bloc.freezed.dart';

class HarryCollectionsBloc extends Bloc<HarryCollectionsEvent, HarryCollectionsState> {
  HarryCollectionsBloc() : super(const _Initial()) {
    on<HarryCollectionsEvent>((event, emit) async {
      var dio = Dio();

      if (event is Bootstrap) {
        emit(const HarryCollectionsState.loading());

        try {
          final response = await dio.get<List<dynamic>>('https://wizard-world-api.herokuapp.com/Elixirs');
          if (response.statusCode == 200) {
            var elixirs = <Elixir>[];

            (response.data)?.forEach((v) {
              try {
                elixirs.add(Elixir.fromJson(v));
              } catch (e) {}
            });

            emit(HarryCollectionsState.loaded(elixirs));
          }
        } on DioError catch (e) {
          emit(HarryCollectionsState.error('Network error: ${e.message}'));
        } catch (e) {
          emit(HarryCollectionsState.error('System error: $e'));
        }
      }
    });
  }
}
