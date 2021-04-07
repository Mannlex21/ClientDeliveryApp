import 'package:client_delivery_app/src/bloc/registration/registration_event.dart';
import 'package:client_delivery_app/src/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Response> post(AddRegistration event) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      )
          .then((value) {
        firestore.collection('companies').doc('${value.user.uid}').set({
          'company': event.company,
          'companyAddress': event.companyAddress,
          'floorOffice': event.floorOffice,
          'name': event.name,
          'lastName': event.lastName,
          'email': event.email,
          'password': event.password,
          'phoneNumber': event.phoneNumber,
          'companyType': event.companyType
        });

        firestore.collection('users').doc("${value.user.uid}").set({
          'email': event.email,
          'password': event.password,
          'name': event.name,
          'lastName': event.lastName,
          'phoneNumber': event.phoneNumber,
        });
      });

      return new Response(true, '', 'success', null);
    } on FirebaseAuthException catch (error) {
      return new Response(false, '${error.code}:', '${error.message}', null);
    } catch (error) {
      return new Response(false, '${error.toString()}:', error.toString(), null);
    }
  }
}
