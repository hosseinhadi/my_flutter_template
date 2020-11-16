import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/binding.dart';
import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';
import 'app/ui/android/pages/home/home_page.dart';
import 'app/ui/theme/app_theme.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: HomeBinding(),
    initialRoute: Routes.HOME,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    home: HomePage(),
    locale: Locale('en', 'US'),
    translationsKeys: AppTranslation.translations,
  ));
}
