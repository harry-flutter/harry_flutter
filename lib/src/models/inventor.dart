import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventor.freezed.dart';
part 'inventor.g.dart';

@freezed
class Inventor with _$Inventor {
  const factory Inventor({
    required String id,
    @Default('') String? firstName,
    @Default('') String? lastName,
  }) = _Inventor;

  factory Inventor.fromJson(Map<String, Object?> json) => _$InventorFromJson(json);
}
