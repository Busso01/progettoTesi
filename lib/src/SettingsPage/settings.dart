import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:progettotesi/core/theme/theme.dart';
import 'package:progettotesi/src/SettingsPage/settings_controller.dart';
import 'package:progettotesi/src/global_widgets/button_custom.dart';
import 'package:progettotesi/src/global_widgets/dialog_custom.dart';


// Classe che rappresenta la pagina delle imèpostazione
class SettingsView extends GetView<SettingsViewController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'settings',
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Colors.black,
          elevation: 5.sp,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            iconSize: 20.sp,
            onPressed: () async {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          title: Text(
            'Impostazioni',
            style: AppTheme.normalContentTextStyleBoldWhite,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
        ),
        backgroundColor: Colors.white,  
        body: ListView(                     // Lista di elementi
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Image.asset(
                'assets/images/settings.png',   // Immagine centrale della pagina
                scale: 1.4, 
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Modalità solo penna: ',
                    style: AppTheme.normalContentTextStyle,
                  ),
                  Obx(
                    () => Switch(                                               // Widget che mostra lo switch
                      activeColor: const Color.fromARGB(255, 107, 99, 255),
                      value: controller.switchPenOnlyValue.value!,
                      onChanged: (value) async {
                        controller.switchPointerMode(value);     // Richama funzione che cambia la modalità di input
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rilevamento traiettoria: ',
                    style: AppTheme.normalContentTextStyle,
                  ),
                  Obx(
                    () => Switch(     // Widget che mostra uno switch
                      activeColor: const Color.fromARGB(255, 107, 99, 255),
                      value: controller.switchTrajectoryCheckingValue.value!,
                      onChanged: (value) async {
                        controller.switchTrajectoryChecking(value);     // Funzione che abilita rilavamento traiettorie
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.w),
                child: ButtonCustom(                                   // Pulsante per resettare i progressi 
                  buttonText: 'Reset Salvataggio',
                  onPressed: () {
                    DialogCustom.removeAllDataDialog(context);
                  },
                  width: 170.w,
                  height: 55.h,
                  paddingHorizontal: 0,
                  fontSize: 15.sp,
                ),
              ),
            ]),
      ),
    );
  }
}
