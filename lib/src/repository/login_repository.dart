import 'package:client_delivery_app/src/bloc/login/login_event.dart';
import 'package:client_delivery_app/src/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Response> authentication(Authentication event) async {
    try {
      final currentUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      return new Response(true, '', 'success', currentUser);
    } on FirebaseAuthException catch (error) {
      return new Response(false, '${error.code}:', '${error.message}', null);
    } catch (error) {
      return new Response(false, '${error.toString()}:', error.toString(), null);
    }
  }

  User getUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser;
  }

  Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Future.wait([auth.signOut()]);
  }
}
