import 'package:freezed_annotation/freezed_annotation.dart';

part 'house.freezed.dart';
part 'house.g.dart';

@freezed
class House with _$House {
  const factory House({
    @Default('') String? id,
    @Default('') String? name,
    @Default('') String? houseColours,
    @Default('') String? founder,
    @Default('') String? animal,
    @Default('') String? element,
    @Default('') String? ghost,
    @Default('') String? commonRoom,
  }) = _House;

  factory House.fromJson(Map<String, Object?> json) => _$HouseFromJson(json);
}
