import 'package:persistence_local_data_storage/src/constant/contact_key.dart';
import 'package:persistence_local_data_storage/src/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/relationship.dart';

class AddContact extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String? name;
  int? age;
  int? phoneNumber;
  Relationship? relationship;

  void onFormSubmit() {
    Box<Contact> contactbox = Hive.box(contactAppBox);
    contactbox.add(Contact(
        age: age!,
        name: name!,
        phoneNumber: phoneNumber!,
        relationship: relationship!));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: widget.formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autocorrect: true,
                    initialValue: '',
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: '',
                    maxLength: 3,
                    maxLengthEnforced: true,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                    onChanged: (value) {
                      setState(() {
                        age = int.parse(value);
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    initialValue: '',
                    maxLength: 11,
                    maxLengthEnforced: true,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = int.parse(value);
                      });
                    },
                  ),
                  DropdownButton<Relationship>(
                      items: relationshipString.keys.map((Relationship value) {
                        return DropdownMenuItem<Relationship>(
                          value: value,
                          child: Text(relationshipString[value].toString()),
                        );
                      }).toList(),
                      
                      value: relationship,
                      hint: const Text('Relationship'),
                      onChanged: (value) {
                        setState(() {
                          relationship = value;
                        });
                      }),
                  OutlineButton(
                    onPressed: onFormSubmit,
                    child: const Text('Submit'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
