import 'package:get/get.dart';
import 'package:progettotesi/core/models/saved_data.dart';
import 'package:progettotesi/core/services/api_service.dart';

// Controller della home page
class HomeViewController extends GetxController {

  // Funzione che permette di ottenere tutti i dati persistenti (se presenti) nel momento in cui l'app viene avviata
  Future<List<SavedData?>?> getAllData() async {
    return await ApiService().getAllPersistenceData();
  }
}
