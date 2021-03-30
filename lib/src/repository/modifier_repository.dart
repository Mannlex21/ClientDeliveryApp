import 'package:client_delivery_app/src/bloc/modifier/modifier_event.dart';
import 'package:client_delivery_app/src/model/itemModifier.dart';
import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:client_delivery_app/src/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ModifierRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Response> add(AddModifier event) async {
    CollectionReference modifiersRef = firestore.collection('modifiers');
    try {
      await modifiersRef.add(event.modifier.toMap());
      return new Response(true, '', 'success', null);
    } on FirebaseAuthException catch (error) {
      return new Response(false, '${error.code}:', '${error.message}', null);
    } catch (error) {
      return new Response(false, '${error.toString()}:', error.toString(), null);
    }
  }

  Future<List<Modifier>> list() async {
    return await firestore.collection("modifiers").get().then((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        List<ItemModifier> marks = [];
        List<dynamic> markMap = doc.data()['list'];
        markMap.forEach((element) {
          marks.add(new ItemModifier(element['name'], double.parse(element['price'].toString()), null));
        });

        return Modifier(
          doc.data()['title'] ?? '',
          marks,
          doc.id,
        );
      }).toList();
    });
  }
}
