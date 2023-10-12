import 'dart:convert';

import 'package:progettotesi/core/models/letters_path.dart';

SavedLetterPath savedLetterPathFromJson(String str) =>
    SavedLetterPath.fromJson(json.decode(str));

String savedLetterPathToJson(SavedLetterPath data) =>
    json.encode(data.toJson());

class SavedLetterPath {
  SavedLetterPath({required this.letterPath});

  List letterPath;

  factory SavedLetterPath.fromJson(Map<String, dynamic> json) =>
      SavedLetterPath(
        letterPath: json["letterPath"],
      );

  Map<String, dynamic> toJson() => {
        "letterPath": letterPath,
      };
}
