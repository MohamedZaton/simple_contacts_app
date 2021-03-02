import 'package:contacts_hive/model/contact.g.dart';
import 'package:contacts_hive/model/relationship.g.dart';
import 'package:contacts_hive/widgets/add_contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'model/contact.dart';
import 'model/relationship.dart';
const String contactsBoxName = "contacts";

const relationships = <Relationship, String>{
  Relationship.Family: "Family",
  Relationship.Friend: "Friend",
};


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(RelationshipAdapter());
  await Hive.openBox<Contact>(contactsBoxName);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDivider() => const SizedBox(height: 5);
    return MaterialApp(
      title: 'Contacts App',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Contacts App with Hive'),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Contact>(contactsBoxName).listenable(),
          builder: (context, Box<Contact> box, _) {
            if (box.values.isEmpty) return Center(child: Text("No contacts"),);
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Contact c = box.getAt(index);
                String relationship = relationships[c.relationship];
                return InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      child: AlertDialog(
                        content: Text(
                          "Do you want to delete ${c.name}?",
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("No"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          FlatButton(
                            child: Text("Yes"),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await box.deleteAt(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildDivider(),
                          Text(c.name),
                          _buildDivider(),
                          Text(c.phoneNumber),
                          _buildDivider(),
                          Text("Age: ${c.age}"),
                          _buildDivider(),
                          Text("Relationship: $relationship"),
                          _buildDivider(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddContact()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
