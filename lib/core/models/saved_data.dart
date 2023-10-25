import 'package:isar/isar.dart';
part 'saved_data.g.dart';

@collection
class SavedData {
  SavedData(
      {required this.trajectories,
      required this.letterIndex,
      required this.compareResults,
      required this.letterDraw});

  Id letterIndex;
  List<bool> compareResults;
  List<bool> trajectories;
  List<String> letterDraw;
}
