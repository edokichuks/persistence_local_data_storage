import 'package:persistence_local_data_storage/src/ui/add_contact/add_contact_viewlmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../model/relationship.dart';

class AddContactView extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  AddContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddContactViewModel>.nonReactive(
      viewModelBuilder: () => AddContactViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                          autocorrect: true,
                          initialValue: '',
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          onChanged: model.onNameChanged),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: '',
                          maxLength: 3,
                          maxLengthEnforced: true,
                          decoration: const InputDecoration(
                            labelText: 'Age',
                          ),
                          onChanged: model.onAgeChanged),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          initialValue: '',
                          maxLength: 11,
                          maxLengthEnforced: true,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                          ),
                          onChanged: model.onPhoneTextFieldChanged),
                      DropdownButton<Relationship>(
                        items:
                            relationshipString.keys.map((Relationship value) {
                          return DropdownMenuItem<Relationship>(
                            value: value,
                            child: Text(relationshipString[value].toString()),
                          );
                        }).toList(),
                        value: model.relationship,
                        hint: const Text('Relationship'),
                        onChanged: model.onRelationshipChanged,
                      ),
                      OutlineButton(
                        onPressed: () => model.onFormSubmit(context),
                        child: const Text('Submit'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
