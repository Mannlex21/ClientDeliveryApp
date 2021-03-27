import 'package:cloud_firestore/cloud_firestore.dart';

class Registration {
  String _company = "";
  String _companyAddress = "";
  String _floorOffice = "";
  String _name = "";
  String _lastName = "";
  String _email = "";
  String _password = "";
  String _phoneNumber = "";
  String _companyType = "";
  String _id = "";

  Registration(
    this._company,
    this._companyAddress,
    this._floorOffice,
    this._name,
    this._lastName,
    this._email,
    this._password,
    this._phoneNumber,
    this._companyType,
    this._id,
  );

  set id(String id) {
    this._id = id;
  }

  set name(String name) {
    this._name = name;
  }

  set company(String company) {
    this._company = company;
  }

  set companyAddress(String companyAddress) {
    this._companyAddress = companyAddress;
  }

  set floorOffice(String floorOffice) {
    this._floorOffice = floorOffice;
  }

  set lastName(String lastName) {
    this._lastName = lastName;
  }

  set email(String email) {
    this._email = email;
  }

  set password(String password) {
    this._password = password;
  }

  set phoneNumber(String phoneNumber) {
    this._phoneNumber = phoneNumber;
  }

  set companyType(String companyType) {
    this._companyType = companyType;
  }

  String get name => this._name;
  String get company => this._company;
  String get companyAddress => this._companyAddress;
  String get floorOffice => this._floorOffice;
  String get lastName => this._lastName;
  String get email => this._email;
  String get password => this._password;
  String get phoneNumber => this._phoneNumber;
  String get companyType => this._companyType;
  String get id => this._id;

  static Registration fromSnapshot(DocumentSnapshot snapshot) {
    return Registration(
      snapshot.data()['_company'],
      snapshot.data()['_companyAddress'],
      snapshot.data()['_floorOffice'],
      snapshot.data()['_name'],
      snapshot.data()['_lastName'],
      snapshot.data()['_email'],
      snapshot.data()['_password'],
      snapshot.data()['_phoneNumber'],
      snapshot.data()['_companyType'],
      snapshot.id,
    );
  }
}
