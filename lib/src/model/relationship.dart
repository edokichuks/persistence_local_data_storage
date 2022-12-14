import 'package:hive/hive.dart';

part 'relationship.g.dart';

@HiveType(typeId: 1)
enum Relationship {
  @HiveField(0)
  Family,
  @HiveField(1)
  Friend,
}

const  relationshipString = <Relationship, String>{
  Relationship.Family: 'Family',
  Relationship.Friend: 'Friend'
};
