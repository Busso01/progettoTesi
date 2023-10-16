// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letters_path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LettersPath _$LettersPathFromJson(Map<String, dynamic> json) => LettersPath(
      capitalBlockLetter: json['capitalBlockLetter'] as Map<String, dynamic>,
      lowerCaseBlockLetter:
          json['lowerCaseBlockLetter'] as Map<String, dynamic>,
      capitalItalic: json['capitalItalic'] as Map<String, dynamic>,
      lowerCaseItalic: json['lowerCaseItalic'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$LettersPathToJson(LettersPath instance) =>
    <String, dynamic>{
      'capitalBlockLetter': instance.capitalBlockLetter,
      'lowerCaseBlockLetter': instance.lowerCaseBlockLetter,
      'capitalItalic': instance.capitalItalic,
      'lowerCaseItalic': instance.lowerCaseItalic,
    };
