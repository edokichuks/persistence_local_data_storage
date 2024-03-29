import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../constant/local_storage_keys.dart';
import '../../model/contact.dart';
import '../../model/relationship.dart';

class AddContactViewModel extends BaseViewModel {
  ///declaration
  String? name;
  int? age;
  int? phoneNumber;
  Relationship? relationship;

  ///Form Submission
  Future<void> onFormSubmit(context) async {
    Box<Contact> contactbox = Hive.box(LocalStorageKey.contactAppBox);
    await contactbox.add(Contact(
        age: age!,
        name: name!,
        phoneNumber: phoneNumber!,
        relationship: relationship!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Contact Added Successfully',
        ),
        // backgroundColor: Colors.grey.shade300
      ),
    );
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

  void relationshipChecked(context) {
    if (relationship == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pls select a relationship'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
