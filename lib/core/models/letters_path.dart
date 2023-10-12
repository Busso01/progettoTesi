import 'package:scribble/scribble.dart';
import 'dart:convert';

LettersPath letterPathFromJson(String str) =>
    LettersPath.fromJson(json.decode(str));

String letterPathToJson(LettersPath data) => json.encode(data.toJson());

class LettersPath {
  LettersPath({
    required this.letter,
    required this.capitalBlockLetter,
    required this.lowerCaseBlockLetter,
    required this.capitalItalic,
    required this.lowerCaseItalic
  });

  int letter;
  Map<String, dynamic> capitalBlockLetter;

  Map<String, dynamic> lowerCaseBlockLetter;
  Map<String, dynamic> capitalItalic;
  Map<String, dynamic> lowerCaseItalic;

  factory LettersPath.fromJson(Map<String, dynamic> json) => LettersPath(
        letter: json["letter"],
        capitalBlockLetter: json["capitalBlockLetter"],
        lowerCaseBlockLetter: json["lowerCaseBlockLetter"],
        capitalItalic: json["capitalItalic"],
        lowerCaseItalic: json["lowerCaseItalic"]
      );

  Map<String, dynamic> toJson() => {
        "letter": letter,
        "capitalBlockLetter": capitalBlockLetter,
        "lowerCaseBlockLetter": lowerCaseBlockLetter,
        "capitalItalic": capitalItalic,
        "lowerCaseItalic": lowerCaseItalic
      };
}
