import 'dart:developer';
import 'package:persistence_local_data_storage/src/model/contact.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistence_local_data_storage/src/constant/contact_key.dart';

import '../../model/relationship.dart';
import '../add_contact/add_contact_view.dart';

class ContactHome extends StatelessWidget {
  ContactHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Contact List'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.dark_mode))
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Contact>(contactAppBox).listenable(),
          builder: (context, Box<Contact> box, child) {
            if (box.values.isEmpty) {
              return const Center(child: Text('No Contacts Yet!\nAdd Up Now'));
            } else {
              return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: ((context, index) {
                    ///Check this link of code
                    Contact? currentContact = box.getAt(index);
                    var relationship =
                        relationshipString[currentContact!.relationship];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 3,
                      color: Colors.teal,
                      shadowColor: Colors.blueGrey,
                      child: InkWell(
                        onLongPress: () {
                          log('On card pressed long');
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                      'Do you want to delete ${currentContact.name}?'),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('NO'),
                                    ),
                                    FlatButton(
                                      onPressed: () async {
                                        await box.deleteAt(index);
                                        Navigator.pop(context);
                                      },
                                      child: Text('YES'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(currentContact.name),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('0' + currentContact.phoneNumber.toString()),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Age: ${currentContact.age}'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Relationship: $relationship'),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddContactView(),
                    ),
                  );
                });
          },
        ));
  }
}
