import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';
import 'inventor.dart';

part 'elixir.freezed.dart';
part 'elixir.g.dart';

@freezed
class Elixir with _$Elixir {
  const factory Elixir({
    @Default('') String? id,
    @Default('') String? name,
    @Default('') String? effect,
    @Default('') String? sideEffects,
    @Default('') String? characteristics,
    @Default('') String? time,
    @Default('') String? difficulty,
    @Default([]) List<Ingredient>? ingredients,
    @Default([]) List<Inventor>? inventors,
    @Default('') String? manufacturer,
  }) = _Elixir;

  factory Elixir.fromJson(Map<String, Object?> json) => _$ElixirFromJson(json);
}
