import 'package:client_delivery_app/src/bloc/registration/registration_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> post(AddRegistration event) async {
    CollectionReference company = FirebaseFirestore.instance.collection('companies');
    try {
      company.add({
        'company': event.company,
        'companyAddress': event.companyAddress,
        'floorOffice': event.floorOffice,
        'name': event.name,
        'lastName': event.lastName,
        'email': event.email,
        'password': event.password,
        'phoneNumber': event.phoneNumber,
        'companyType': event.companyType
      }).then((value) {
        FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
      }).catchError((error) => print("Failed to add company: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
