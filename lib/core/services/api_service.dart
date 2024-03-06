import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progettotesi/core/models/saved_data.dart';
import 'package:progettotesi/src/global_widgets/snackbar_custom.dart';

// Classe che permette l'interazione con il DB Isar
class ApiService {
  List<SavedData?> savedData = [];

  // Funzione che interroga il DB ed ottiene tutti i dati persistenti salvati
  Future<List<SavedData?>?> getAllPersistenceData() async {
    Isar? isar;
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([SavedDataSchema], directory: dir.path);
      List<int> iDs = [];
      for (int i = 0; i < 26; i++) {
        iDs.add(i);
      }
      var results = await isar.savedDatas.getAll(iDs);
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

  // Funzione che permette di salvare nel DB i risultati di una comparazione
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

  // Funzione che permette di resettare tutti i dati di salvataggio
  Future<bool> removeAllPersistenceData() async {
    Isar? isar;
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([SavedDataSchema], directory: dir.path);

      for (int i = 0; i < 26; i++) {
        var results = await isar.savedDatas.get(i);
        if (results != null) {
          await isar.writeTxn(() async {
            await isar!.savedDatas.delete(results.letterIndex);
          });
        }
      }
      isar.close();
      return true;
    } catch (e) {
      snackbarCustomDanger(
          'Rimozione', 'Errore nella rimozione dei \n dati di salvataggio');
      if (isar != null && isar.isOpen) isar.close();
      return false;
    }
  }
}
