import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/constant/contact_key.dart';
import 'src/model/contact.dart';
import 'src/model/relationship.dart';
import 'src/ui/home/home_view.dart';

void main() async {
  await Hive.initFlutter();

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
            themeMode: darkMode
                ? ThemeMode.dark
                : ThemeMode.light, // ThemeData(primaryColor: Colors.teal),
            home: const HomeView(),
          );
        });
  }
}
