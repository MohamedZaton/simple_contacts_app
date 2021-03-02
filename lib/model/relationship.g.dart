import 'package:contacts_hive/model/relationship.dart';
import 'package:hive/hive.dart';

class RelationshipAdapter extends TypeAdapter<Relationship> {
  @override
  final typeId = 1;

  @override
  Relationship read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Relationship.Family;
      case 1:
        return Relationship.Friend;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Relationship obj) {
    switch (obj) {
      case Relationship.Family:
        writer.writeByte(0);
        break;
      case Relationship.Friend:
        writer.writeByte(1);
        break;
    }
  }
}

