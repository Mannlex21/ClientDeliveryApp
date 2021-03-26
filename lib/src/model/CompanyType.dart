import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyType {
  String _name;
  String _description;
  String _id;

  CompanyType(this._name, this._description, this._id);

  set id(String id) {
    this._id = id;
  }

  set name(String name) {
    this._name = name;
  }

  set description(String description) {
    this._description = description;
  }

  String get name => this._name;
  String get description => this._description;
  String get id => this._id;

  static CompanyType fromSnapshot(DocumentSnapshot snapshot) {
    return CompanyType(snapshot.data()['name'], snapshot.data()['description'], snapshot.id);
  }
}
