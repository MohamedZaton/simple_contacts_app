import 'package:contacts_hive/model/contact.dart';
import 'package:contacts_hive/model/relationship.dart';
import 'package:hive/hive.dart';

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final typeId = 0;

  @override
  Contact read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      fields[0] as String,
      fields[1] as int,
      fields[3] as String,
      fields[2] as Relationship,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.relationship)
      ..writeByte(3)
      ..write(obj.phoneNumber);
  }
}
