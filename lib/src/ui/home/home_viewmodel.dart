import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';
import '../../constant/contact_key.dart';
import '../../model/contact.dart';

class HomeViewModel extends BaseViewModel {
  Box<Contact> appBox = Hive.box<Contact>(contactAppBox);
  Box themeBox = Hive.box(contactAppTheme);
  var isDark = Hive.box(contactAppTheme).get('isDark');

  void toggleTheme() {
    log('Theme icon clicked with : ${isDark}');
    isDark = !isDark;
    notifyListeners();
  }
}
