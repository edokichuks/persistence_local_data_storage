import 'package:hive/hive.dart';

part 'relationship.g.dart';

@HiveType(typeId: 1)
enum Relationship {
  @HiveField(0)
  // ignore: constant_identifier_names
  Family,
  @HiveField(1)
  // ignore: constant_identifier_names
  Friend,
}

const  relationshipString = <Relationship, String>{
  Relationship.Family: 'Family',
  Relationship.Friend: 'Friend'
};
