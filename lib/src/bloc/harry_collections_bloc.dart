import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/elixir.dart';

part 'harry_collections_event.dart';
part 'harry_collections_state.dart';
part 'harry_collections_bloc.freezed.dart';

class HarryCollectionsBloc extends Bloc<HarryCollectionsEvent, HarryCollectionsState> {
  HarryCollectionsBloc() : super(const _Initial()) {
    // ignore: non_constant_identifier_names
    final BASE_URL = dotenv.env['BASE_URL'];

    on<HarryCollectionsEvent>((event, emit) async {
      var dio = Dio();

      if (event is Bootstrap) {
        emit(const HarryCollectionsState.loading());

        try {
          final response = await dio.get<List<dynamic>>('$BASE_URL/Elixirs');
          if (response.statusCode == 200) {
            var elixirs = <Elixir>[];

            for (final v in response.data as List<dynamic>) {
              elixirs.add(Elixir.fromJson(v));
            }

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
