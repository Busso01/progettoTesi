import 'package:get/get.dart';
import 'package:progettotesi/core/models/saved_data.dart';
import 'package:progettotesi/src/DrawPage/draw_page_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Controller della pagina di selezione
class SelectionViewController extends GetxController {
  List<SavedData?> savedData = [];
  late SharedPreferences prefs;

  // Nella fase di inizializzazione vengono ottenuti i dati persistenti e l'istanza di sharedPreferences
  @override
  void onInit() async {
    savedData = Get.arguments;
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  // Funzione che verifica i progressi dell'utente su ogni lettera
  int checkSavedDatas(int letterIndex) {
    bool allDone = true;
    bool atLeastOne = false;

    // Si verifica se almeno una delle lettere, sia come accuratezza che come traiettoria, sia stata completata
    if (savedData[letterIndex] != null) {  
      for (bool element in savedData[letterIndex]!.compareResults) {
        if (element == true) {
          atLeastOne = true;
        } else {
          allDone = false;
        }
      }
      for (bool element in savedData[letterIndex]!.trajectories) {
        if (element == true) {
          atLeastOne = true;
        } else {
          allDone = false;
        }
      }

      // Dopo di che si restituisce il risultato
      if (allDone) {
        return 2;
      } else if (atLeastOne) {
        return 1;
      } else {
        return 0;
      }
    }
    return 0;
  }

  // Funzione che inizializza il controller della pagina di scrittura
  /*
    Avendo utilizzato un openContainer non è stato possibile utilizzare l'inizializzazione standard tramite
    GetX, ho quindi utilizzato direttamente il controller della selection view per impostare tutti i parametri
    della DrawPage in base alla lettera che è stata scelta
  */
  void initializeDrawPageController(int selectedLetterIndex) {
    bool? trajectoryCheckingValue = prefs.getBool('trajectoryChecking');
    DrawPageController drawPageController = Get.put(DrawPageController());
    drawPageController.selectedLetter = String.fromCharCode(selectedLetterIndex + 65);
    drawPageController.selectedLetterIndex = selectedLetterIndex;
    drawPageController.isTrajectoryCheckingOnValue =
        trajectoryCheckingValue ?? false;

    if (savedData[selectedLetterIndex] != null) {
      drawPageController.savedDataSingleSet = savedData[selectedLetterIndex]!;
    } else {
      // Nel caso in cui non siano presenti dati di salvataggio, ne crea uno di Default, per evitare di gestire dei Null
      SavedData defaultData = SavedData(
          trajectories: [false, false, false, false],
          letterIndex: selectedLetterIndex,
          compareResults: [false, false, false, false],
          letterDraw: ["", "", "", ""]);
      drawPageController.savedDataSingleSet = defaultData;
    }
  }
}
