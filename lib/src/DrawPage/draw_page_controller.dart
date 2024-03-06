import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/jsonLetterModel/letters_path.dart';
import 'package:progettotesi/core/models/saved_data.dart';
import 'package:progettotesi/core/jsonLetterModel/saved_letters_path.dart';
import 'package:progettotesi/core/services/api_service.dart';
import 'package:progettotesi/src/global_widgets/snackbar_custom.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scribble/scribble.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

/* Controller relativo alla pagina di scrittura */

class DrawPageController extends GetxController {
  // Vengono inizializzati tutti gli scribble notifier per la  zona di scrittura
  List<ScribbleNotifier> scribbleNotifier = [
    ScribbleNotifier(),
    ScribbleNotifier(),
    ScribbleNotifier(),
    ScribbleNotifier()
  ];

  // Inizializzazione dei controller
  ScreenshotController screenshotController = ScreenshotController();
  PageController pageController = PageController(viewportFraction: 0.8);

  // Dichiarazione delle variabili che conterranno le immagini delle lettere
  Uint8List? widget;
  Uint8List? draw;

  // Dichiarazione delle variabili che conterranno le immagini delle lettere nel giusto formato per il confronto
  img.Image? drawImage;
  img.Image? widgetImage;

  // Una mappa che contiene il percorso fatto nella scrittura della lettera, utilizzata solo nel caso in cui
  // sia necessario aggiornare le traiettorie
  // Map<String, dynamic> paths = {};

  // Variabile osservabile per effettuare l'apertura della card
  var isExpanded = false.obs;

  // Dichiarazione variabili che verranno inizializzate nel momento in cui viene creato il controller
  late String selectedLetter;
  late int selectedLetterIndex;
  late SavedData savedDataSingleSet;
  late bool isTrajectoryCheckingOnValue;

  // Impostazione dei corretti settaggi per gli scribbleNotifier
  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < scribbleNotifier.length; i++) {
      setScribbleNotifierSettings(i);
    }
  }

  @override
  void onClose() {
    scribbleNotifier[0].dispose();
    scribbleNotifier[1].dispose();
    scribbleNotifier[2].dispose();
    scribbleNotifier[3].dispose();
    pageController.dispose();
    super.onClose();
  }

  // Funzione per il salvataggio della lettera originale
  Future<void> saveLetter(Widget widgetPassed) async {
    widget = await screenshotController.captureFromWidget(widgetPassed,
        delay: const Duration(seconds: 0));
    widgetImage = img.decodeImage(widget!);
    widget = null;
  }

  // Funzione per il salvataggio dello Widget contenente la lettera scritta dall'utente
  Future<void> saveDrawWidget(Widget widgetPassed) async {
    draw = await screenshotController.captureFromWidget(widgetPassed,
        delay: const Duration(seconds: 0));
    drawImage = img.decodeImage(draw!);
    draw = null;
  }

  // Funzione per il salvataggio della lettera scritta dall'utente
  Future<bool> saveDraw(int index) async {
    Sketch sketch = scribbleNotifier[index].currentSketch;
    if (sketch.lines.isNotEmpty) {
      var image = await scribbleNotifier[index].renderImage();
      draw = image.buffer.asUint8List();
      return true;
    }
    return false;
  }

  // Funzione che permette l'apertura della card della lettera
  void openDetailPage() {
    if (!isExpanded.value) {
      isExpanded.value = true;
    } else {
      isExpanded.value = false;
      clearAllScribbles();
    }
  }

  // Funzione per pulire tutti gli scribble
  void clearAllScribbles() {
    scribbleNotifier[0].clear();
    scribbleNotifier[1].clear();
    scribbleNotifier[2].clear();
    scribbleNotifier[3].clear();
  }

  // Funzione per resettare alcuni parametri del controller quando viene chiusa la pagina di scrittura
  void resetControllerValues() {
    clearAllScribbles();
    isExpanded.value = false;
  }

  // Funzione di selezione del titolo corretto in base allo stile di lettera mostrato
  String selectTitle(int index) {
    switch (index) {
      case 0:
        return 'Stampatello \n maiuscolo';
      case 1:
        return 'Stampatello \n minuscolo';
      case 2:
        return 'Corsivo \n maiuscolo';
      case 3:
        return 'Corsivo \n minuscolo';
    }
    return '';
  }

  // Funzione per verificare i progressi fatti dall'utente e mostrarli correttamente
  int checkSavedData(int index) {
    bool result = savedDataSingleSet.compareResults[index];
    bool trajectories = savedDataSingleSet.trajectories[index];
    if (result && trajectories) {
      return 1;
    } else if (result) {
      return 2;
    } else if (trajectories) {
      return 3;
    } else {
      return 0;
    }
  }

  // Funzione per verificare se sono presenti dati di salvataggio relativi alla lettera scelta
  bool checkIfAlreadyDone(int letterIndex) {
    if (!isExpanded.value) {
      if (checkSavedData(letterIndex) == 1) {
        return true;
      }
    }
    return false;
  }

  // Funzione che impsota i parametri dello scribble notifier, prendendo informazini anche da SharedPreferences
  void setScribbleNotifierSettings(int index) async {
    try {
      await SharedPreferences.getInstance().then((value) {
        bool? penOnly = value.getBool('penOnly');
        if (penOnly != null) {
          if (!penOnly) {
            scribbleNotifier[index]
                .setAllowedPointersMode(ScribblePointerMode.all);
          } else {
            scribbleNotifier[index]
                .setAllowedPointersMode(ScribblePointerMode.penOnly);
          }
        } else {
          scribbleNotifier[index]
              .setAllowedPointersMode(ScribblePointerMode.penOnly);
        }
      });
      if (index == 0 || index == 1) {
        scribbleNotifier[index].setStrokeWidth(1.25.sp);
      } else if (index == 3) {
        scribbleNotifier[index].setStrokeWidth(1.0.sp);
      } else {
        scribbleNotifier[index].setStrokeWidth(1.05.sp);
      }
    } catch (e) {
      snackbarCustomDanger("Errore Salvataggio Impostazione", e.toString());
    }
  }

  // Funzione che effettua la comparazione tra le immagini, conta il numero di pixel delle due immagini,
  // conta il numero di pixel neri, ed effettua il confronto
  bool compareImage() {
    int numBlackPixelDraw = 0;
    int numBlackPixelWidget = 0;
    int numPixelMatching = 0;
    for (int y = 0; y < drawImage!.height; y++) {
      for (int x = 0; x < drawImage!.width; x++) {
        final pixelDraw = drawImage!.getPixel(x, y);
        final pixelWidget = widgetImage!.getPixel(x, y);

        if (img.isBlack(pixelWidget)) {
          numBlackPixelWidget++;
        }

        if (img.isBlack(pixelDraw)) {
          numBlackPixelDraw++;
        }

        if ((img.isBlack(pixelDraw) && img.isBlack(pixelWidget))) {
          numPixelMatching++;
        }
      }
    }

    if (numBlackPixelDraw >= numBlackPixelWidget * 0.45 &&      // controllo del numero di pixel
        numBlackPixelDraw <= numBlackPixelWidget * 1.2) {       // modificare questo parametro per cambiare la precisione richiesta
      if (numPixelMatching >= numBlackPixelWidget * 0.40) {
        return true;
      }
    }
    return false;
  }

  // Funzione per il controllo della traiettoria
  Future<bool> checkLetterPath(int index) async {
    if (isTrajectoryCheckingOnValue) {              // controllo effettuato solo se la funzione è abilitata
      try {
        Sketch? letter = await loadSketchFromJson(index);
        Sketch draw = scribbleNotifier[index].currentSketch;
        if (draw.lines.length != letter!.lines.length) {
          return false;
        } else {
          for (int i = 0; i < letter.lines.length; i++) {
            List<Point> drawLines = draw.lines[i].points;
            List<Point> letterLines = letter.lines[i].points;
            double dtw = calculateDTW(drawLines, letterLines);
            if (dtw > 3) {
              return false;
            }
          }
          return true;
        }
      } catch (e) {
        snackbarCustomDanger('Errore controllo traiettoria',
            'Si è verificato un errore nella verifica \n della traiettoria, riprovare');
      }
    }
    return true;
  }

  // Funzione che calcola il DTW basandosi sulle traiettorie salvate e quelle ottenute dalla lettera scritta
  double calculateDTW(List drawLines, List letterLines) {
    List<List> dtw = List.generate(drawLines.length,
        (index) => List.generate(letterLines.length, (index) => 0.0));
    double cost;

    for (int i = 0; i < drawLines.length; i++) {
      for (int j = 0; j < letterLines.length; j++) {
        dtw[i][j] = double.infinity;
      }
    }
    dtw[0][0] = 0;
    for (int i = 1; i < drawLines.length; i++) {
      for (int j = 1; j < letterLines.length; j++) {
        cost = sqrt(pow((drawLines[i].x - letterLines[j].x), 2) +
            pow((drawLines[i].y - letterLines[j].y), 2));
        dtw[i][j] =
            cost + min(dtw[i - 1][j], min(dtw[i][j - 1], dtw[i - 1][j - 1]));
      }
    }

    return sqrt(dtw[drawLines.length - 1][letterLines.length - 1] /
        max(drawLines.length, letterLines.length));
  }

  // Fun<ione che salva il risultato della comparazione
  Future<bool> saveResult(bool result, int index, bool trajectories) async {
    savedDataSingleSet.compareResults[index] = result;
    savedDataSingleSet.trajectories[index] = trajectories;
    savedDataSingleSet.letterDraw[index] =
        jsonEncode(scribbleNotifier[index].currentSketch);

    return ApiService()
        .saveResultAPI(savedDataSingleSet)
        .then((value) => value);
  }

  // Funzione che carica le traiettorie ideali salvate nel file json integrato nell'applicazione
  Future<Sketch?> loadSketchFromJson(int letterStyleIndex) async {
    String jsonString = await rootBundle.loadString('assets/path.json');
    Map<String, dynamic> mapFromJson = jsonDecode(jsonString);
    SavedLetterPath savedLetterPath = SavedLetterPath.fromJson(mapFromJson);
    LettersPath lettersPath =
        LettersPath.fromJson(savedLetterPath.letterPath[selectedLetter]);

  // Restituisce il path ideale in base allo stile richiesto
    switch (letterStyleIndex) {
      case 0:
        return Sketch.fromJson(lettersPath.capitalBlockLetter);
      case 1:
        return Sketch.fromJson(lettersPath.lowerCaseBlockLetter);
      case 2:
        return Sketch.fromJson(lettersPath.capitalItalic);
      case 3:
        return Sketch.fromJson(lettersPath.lowerCaseItalic);
      default:
        return null;
    }
  }

  // Funzione utilizzata per salvare le traiettorie nel file json, può essere utile nel caso dovessero essere aggiornate
  // void printJson() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = directory.path;
  //   final file = File('$path/path.json');

  //   LettersPath lettersPath = LettersPath(
  //       capitalBlockLetter: scribbleNotifier[0].currentSketch.toJson(),
  //       lowerCaseBlockLetter: scribbleNotifier[1].currentSketch.toJson(),
  //       capitalItalic: scribbleNotifier[2].currentSketch.toJson(),
  //       lowerCaseItalic: scribbleNotifier[3].currentSketch.toJson());
  //   paths[selectedLetter] = lettersPath;

  //   SavedLetterPath savedLetterPath = SavedLetterPath(letterPath: paths);
  //   String savedPathJson = jsonEncode(savedLetterPath);

  //   file.writeAsString(savedPathJson);
  // }
}
