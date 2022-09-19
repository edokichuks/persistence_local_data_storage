import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../constant/contact_key.dart';
import '../../model/contact.dart';
import '../../model/relationship.dart';

class AddContactViewModel extends BaseViewModel {
  ///declaration
  String? name;
  int? age;
  int? phoneNumber;
  Relationship? relationship;
  // String name = '';
  // int age = 0;
  // int phoneNumber = 0;
  // Relationship relationship = Relationship.Friend;

  ///Form Submission
  Future<void> onFormSubmit(context) async {
    Box<Contact> contactbox = Hive.box(contactAppBox);
    await contactbox.add(Contact(
        age: age!,
        name: name!,
        phoneNumber: phoneNumber!,
        relationship: relationship!));
    Navigator.pop(context);
  }

  void onNameChanged(String value) {
    name = value;
    notifyListeners();
  }

  void onAgeChanged(String value) {
    age = int.parse(value);
    notifyListeners();
  }

  void onRelationshipChanged(Relationship? value) {
    relationship = value;
    
    notifyListeners();
  }

  void onPhoneTextFieldChanged(String value) {
    phoneNumber = int.parse(value);
    notifyListeners();
  }
}
