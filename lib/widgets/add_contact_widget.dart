

import 'package:contacts_hive/model/contact.dart';
import 'package:contacts_hive/model/relationship.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../main.dart';

class AddContact extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String name;
  int age;
  String phoneNumber;
  Relationship relationship;

  void onFormSubmit() {
    if (widget.formKey.currentState.validate()) {
      Box<Contact> contactsBox = Hive.box<Contact>(contactsBoxName);
      contactsBox.add(Contact(name, age, phoneNumber, relationship));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: widget.formKey,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              TextFormField(
                autofocus: true,
                initialValue: "",
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: "",
                maxLength: 3,
                maxLengthEnforced: true,
                decoration: const InputDecoration(
                  labelText: "Age",
                ),
                onChanged: (value) {
                  setState(() {
                    age = int.parse(value);
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                initialValue: "",
                decoration: const InputDecoration(
                  labelText: "Phone",
                ),
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              DropdownButtonFormField(
                items: relationships.keys.map((Relationship value) {
                  return DropdownMenuItem<Relationship>(
                    value: value,
                    child: Text(relationships[value]),
                  );
                }).toList(),
                value: relationship,
                hint: Text("Relationship"),
                onChanged: (value) {
                  setState(() {
                    relationship = value;
                  });
                },
              ),
              OutlineButton(
                child: Text("Submit"),
                onPressed: onFormSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
