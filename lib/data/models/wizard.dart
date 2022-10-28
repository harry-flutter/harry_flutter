import 'package:freezed_annotation/freezed_annotation.dart';

import './elixir.dart';

part 'wizard.freezed.dart';
part 'wizard.g.dart';

@freezed
class Wizard with _$Wizard {
  const factory Wizard({
    @Default('') String? id,
    @Default('') String? firstName,
    @Default('') String? lastName,
    @Default([]) List<Elixir>? elixirs,
  }) = _Wizard;

  factory Wizard.fromJson(Map<String, Object?> json) => _$WizardFromJson(json);
}
