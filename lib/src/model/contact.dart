
import 'package:hive/hive.dart';

import 'relationship.dart';


part 'contact.g.dart';
@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  int phoneNumber;

  @HiveField(3)
  Relationship relationship;

   Contact({required this.age, required this.name, required this.phoneNumber, required this.relationship});
}
