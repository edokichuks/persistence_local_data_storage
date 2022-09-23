import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistence_local_data_storage/src/ui/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../model/contact.dart';
import '../../model/relationship.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(model.homeAppTitle),
                centerTitle: true,
                actions: [
                  ValueListenableBuilder(
                    valueListenable: model.themeBox.listenable(),
                    builder: (context, Box box, child) {
                      final darkMode = model.themeBox.get('isDark');
                      return IconButton(
                        onPressed: model.toggleTheme,
                        icon: darkMode
                            ? Icon(
                                Icons.light_mode,
                                color: Colors.grey.shade100,
                              )
                            : Icon(
                                Icons.dark_mode,
                                color: Colors.grey.shade300,
                              ),
                      );
                    },
                  )
                ],
              ),
              body: ValueListenableBuilder(
                valueListenable: model.appBox.listenable(),
                builder: (context, Box<Contact> box, child) {
                  if (box.values.isEmpty) {
                    return const Center(child: Text('No Contacts Yet!'));
                  } else {
                    return ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: ((context, index) {
                          Contact? currentContact = box.getAt(index);
                          var relationship =
                              relationshipString[currentContact!.relationship];
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 10,
                            shadowColor: Colors.blueGrey.withOpacity(0.5),
                            child: InkWell(
                              onLongPress: () {
                                log('On card pressed long');
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Warning!'),
                                        elevation: 5,
                                        content: Text(
                                            'Do you want to delete ${currentContact.name}?'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('NO'),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.grey.shade400),
                                            ),
                                            onPressed: () async {
                                              await box.deleteAt(index);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('YES'),
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
                                    Text('0' +
                                        currentContact.phoneNumber.toString()),
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Builder(
                builder: (context) {
                  return FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: model.navigateToAddContact,
                  );
                },
              ));
        });
  }
}
