import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistence_local_data_storage/src/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

import 'src/app/app.router.dart';
import 'src/constant/contact_key.dart';
import 'src/model/contact.dart';
import 'src/model/relationship.dart';
import 'src/ui/home/home_view.dart';

void main() async {
  await Hive.initFlutter();

  ///initialize locator setup
  await setupLocator();

  ///Registration of adapters
  Hive.registerAdapter<Contact>(ContactAdapter());
  Hive.registerAdapter(RelationshipAdapter());

  ///opening of boxes
  await Hive.openBox<Contact>(contactAppBox);
  await Hive.openBox(contactAppTheme);

  runApp(const ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box themeBox = Hive.box(contactAppTheme);

    return ValueListenableBuilder(
        valueListenable: themeBox.listenable(),
        builder: (context, Box box, child) {
          final darkMode = box.get('isDark', defaultValue: false);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Contact List',
            darkTheme: ThemeData.dark(),
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light, //
            // ThemeData(primaryColor: Colors.teal),
            navigatorKey: StackedService.navigatorKey,

            onGenerateRoute: StackedRouter().onGenerateRoute,
          );
        });
  }
}
