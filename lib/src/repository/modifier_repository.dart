import 'package:client_delivery_app/src/bloc/modifier/modifier_event.dart';
import 'package:client_delivery_app/src/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ModifierRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Response> addModifier(AddModifier event) async {
    CollectionReference modifiersRef = FirebaseFirestore.instance.collection('modifiers');
    try {
      await modifiersRef.add(event.modifier.toMap());
      return new Response(true, '', 'success', null);
    } on FirebaseAuthException catch (error) {
      return new Response(false, '${error.code}:', '${error.message}', null);
    } catch (error) {
      return new Response(false, '${error.toString()}:', error.toString(), null);
    }
  }
}
