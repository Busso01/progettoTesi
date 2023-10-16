import 'package:json_annotation/json_annotation.dart';
part 'saved_letters_path.g.dart';

@JsonSerializable()
class SavedLetterPath {
  SavedLetterPath({required this.letterPath});

  Map<String, dynamic> letterPath;

  factory SavedLetterPath.fromJson(Map<String, dynamic> json) =>
      _$SavedLetterPathFromJson(json);

  Map<String, dynamic> toJson() => _$SavedLetterPathToJson(this);
}
