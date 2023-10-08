import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progettotesi/core/models/saved_data.dart';
import 'package:progettotesi/src/global_widgets/snackbar_custom.dart';

class ApiService {
  List<SavedData?> savedData = [];

  Future<List<SavedData?>?> getAllPersistenceData() async {
    Isar? isar;
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([SavedDataSchema], directory: dir.path);
      List<int> ids = [];
      for (int i = 0; i < 26; i++) {
        ids.add(i);
      }
      var results = await isar.savedDatas.getAll(ids);
      savedData.addAll(results);
      isar.close();
      return savedData;
    } catch (e) {
      snackbarCustomDanger(
          'Salvataggio', 'Errore nel caricamento dei \n dati di salvataggio');
      if (isar != null && isar.isOpen) isar.close();
      return null;
    }
  }

  Future<bool> saveResultAPI(SavedData dataToSave) async {
    Isar? isar;
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([SavedDataSchema], directory: dir.path);
      await isar.writeTxn(() async {
        await isar!.savedDatas.put(dataToSave);
      });
      isar.close();
      return true;
    } catch (e) {
      snackbarCustomDanger(
          'Salvataggio', 'Errore nel caricamento dei \n dati di salvataggio');
      if (isar != null && isar.isOpen) isar.close();
      return false;
    }
  }
}
