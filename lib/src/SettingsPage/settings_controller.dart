import 'package:get/get.dart';
import 'package:progettotesi/core/services/api_service.dart';
import 'package:progettotesi/src/global_widgets/snackbar_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Controller della pagina delle impostazioni 
class SettingsViewController extends GetxController {

  // Crea l'istanza di sharedPreferences, in modo da rendere permanenti le scelte, anche dopo la chiusura dell'app
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // vengono inizializzate due variebili osservabili per lo stato della modalità di input e rilevamento traiettorie
  Rx<bool?> switchPenOnlyValue = true.obs;
  Rx<bool?> switchTrajectoryCheckingValue = false.obs;

  // In fase di inizializzazione, se già impostati, vengono ottenuti i valori attuali di input e traiettoria
  @override
  void onInit() {
    checkSwitchValue();
    checkTrajectoryCheckingValue();
    super.onInit();
  }

  // Funzione che ottine, se già presente, il valore della modalità di input
  void checkSwitchValue() async {
    try {
      SharedPreferences prefs = await _prefs;
      bool? savedValue = prefs.getBool('penOnly');

      // Se non è mai stata impostata, di Default viene impostata a true
      if (savedValue != null) {
        switchPenOnlyValue.value = savedValue;
      } else {
        await prefs.setBool('penOnly', true);
      }
    } catch (e) {
      snackbarCustomDanger('Errore',
          'Si è verificato un problma nel cambio della modalità, riprova');
    }
  }

  // Funzione che ottine, se già presente, il valore del rievamento della traiettoria
  void checkTrajectoryCheckingValue() async {
    try {
      SharedPreferences prefs = await _prefs;
      bool? savedValue = prefs.getBool('trajectoryChecking');

      // Se non è mai stata impostata, di Default viene impostata a false
      if (savedValue != null) {
        switchTrajectoryCheckingValue.value = savedValue;
      } else {
        await prefs.setBool('trajectoryChecking', false);
      }
    } catch (e) {
      snackbarCustomDanger('Errore',
          'Si è verificato un problma nel cambio della modalità, riprova');
    }
  }

  // Funzione che richiama le API per elimianre tutti i dati
  void deleteAllDatas() async {
    await ApiService().removeAllPersistenceData().then((value) {
      if (value) {
        snackbarCustomSuccess(
            'Successo', 'Tutti i dati sono stati ripristinati con successo');
      } else {
        snackbarCustomDanger('Fallimento',
            'Si è verificato un problema nella cancellazione dei dati');
      }
    });
  }

  // Funzione che permette di cambiare la modalità di input e renderla persistente
  void switchPointerMode(bool value) async {
    SharedPreferences prefs = await _prefs;
    switchPenOnlyValue.value = value;
    prefs.setBool('penOnly', value);
  }

  // Funzione che permette di abilitare il rilevamento della traiettoria e renderlo persistente
  void switchTrajectoryChecking(bool value) async {
    SharedPreferences prefs = await _prefs;
    switchTrajectoryCheckingValue.value = value;
    prefs.setBool('trajectoryChecking', value);
  }
}
