import 'package:get/get.dart';
import 'package:progettotesi/core/services/api_service.dart';
import 'package:progettotesi/src/global_widgets/snackbar_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Rx<bool?> switchValue = true.obs;

  @override
  void onInit() {
    checkSwitchValue();
    super.onInit();
  }

  void checkSwitchValue() async {
    try {
      SharedPreferences prefs = await _prefs;
      bool? savedValue = prefs.getBool('penOnly');
      if (savedValue != null) {
        switchValue.value = savedValue;
      } else {
        await prefs.setBool('penOnly', true);
      }
    } catch (e) {
      snackbarCustomDanger('Errore',
          'Si è verificato un problma nel cambio della modalità, riprova');
    }
  }

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

  void switchPointerMode(bool value) async {
    SharedPreferences prefs = await _prefs;
    switchValue.value = value;
    prefs.setBool('penOnly', value);
  }
}
