import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';
import '../../constant/contact_key.dart';
import '../../model/contact.dart';

class HomeViewModel extends BaseViewModel {
  String homeAppTitle = 'My Contact List';

  Box<Contact> appBox = Hive.box<Contact>(contactAppBox);
  Box themeBox = Hive.box(contactAppTheme);

  //darkMode() => themeBox.get('isDark');

  void toggleTheme() {
    final darkMode = themeBox.get('isDark');

    themeBox.put('isDark', false);
    log('Darkmode is ' + darkMode.toString());
    themeBox.put('isDark', !darkMode);

    notifyListeners();
  }
}
