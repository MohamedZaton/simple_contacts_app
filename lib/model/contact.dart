import 'package:contacts_hive/model/relationship.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  Relationship relationship;
  @HiveField(3)
  String phoneNumber;
  Contact(this.name, this.age, this.phoneNumber, this.relationship);
}