import 'package:isar/isar.dart';
part 'saved_data.g.dart';

@collection
class SavedData {
  SavedData({required this.letterIndex, required this.results});

  Id letterIndex;
  List<bool> results;
}
