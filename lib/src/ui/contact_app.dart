
import 'package:flutter/material.dart';

import 'home/contact_home.dart';

class ContactApp extends StatelessWidget {
  const ContactApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      theme: ThemeData(primaryColor: Colors.teal),
      home:  ContactHome(),
    );
  }
}
