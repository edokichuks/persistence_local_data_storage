import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.dart';
import '../../app/app.router.dart';
import '../../constant/contact_key.dart';
import '../../model/contact.dart';

class HomeViewModel extends BaseViewModel {
  String homeAppTitle = 'My Contact List';
  final navigator = locator<NavigationService>();

  Box<Contact> appBox = Hive.box<Contact>(contactAppBox);
  Box themeBox = Hive.box(contactAppTheme);

  void toggleTheme() {
    final darkMode = themeBox.get('isDark');
    themeBox.put('isDark', false);
    log('DarkMode is ' + darkMode.toString());
    themeBox.put('isDark', !darkMode);

    notifyListeners();
  }

  void navigateToAddContact() => navigator.navigateTo(Routes.addContactView);
}
