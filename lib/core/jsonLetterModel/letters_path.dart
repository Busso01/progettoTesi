import 'package:json_annotation/json_annotation.dart';
part 'letters_path.g.dart';

@JsonSerializable()
class LettersPath {
  LettersPath(
      {required this.capitalBlockLetter,
      required this.lowerCaseBlockLetter,
      required this.capitalItalic,
      required this.lowerCaseItalic});

  Map<String, dynamic> capitalBlockLetter;
  Map<String, dynamic> lowerCaseBlockLetter;
  Map<String, dynamic> capitalItalic;
  Map<String, dynamic> lowerCaseItalic;

  factory LettersPath.fromJson(Map<String, dynamic> json) =>
      _$LettersPathFromJson(json);

  Map<String, dynamic> toJson() => _$LettersPathToJson(this);
}
