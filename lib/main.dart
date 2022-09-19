import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/constant/contact_key.dart';
import 'src/model/contact.dart';
import 'src/model/relationship.dart';

import 'src/ui/home/contact_home.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Contact>(ContactAdapter());
  Hive.registerAdapter(RelationshipAdapter());

  await Hive.openBox<Contact>(contactAppBox);
  runApp(const ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      theme: ThemeData(primaryColor: Colors.teal),
      home: ContactHome(),
    );
  }
}
