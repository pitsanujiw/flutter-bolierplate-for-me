import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class Language {
  final String code;
  final Map<String, dynamic> value;

  Language({
    this.code,
    this.value,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
