import 'package:flutter/cupertino.dart';

extension ValidationExtension on BuildContext {
  String? validateTextField(String? value) =>
      value == null || value.isEmpty ? 'Field cannot be empty' : null;
}
