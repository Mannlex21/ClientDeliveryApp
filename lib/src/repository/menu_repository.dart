import 'package:client_delivery_app/src/bloc/menu/menu_event.dart_event.dart';
import 'package:client_delivery_app/src/model/itemModifier.dart';
import 'package:client_delivery_app/src/model/menu.dart';
import 'package:client_delivery_app/src/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Response> add(AddMenu event) async {
    CollectionReference modifiersRef = firestore.collection('modifiers');
    try {
      await modifiersRef.add(event.menu.toMap());
      return new Response(true, '', 'success', null);
    } on FirebaseAuthException catch (error) {
      return new Response(false, '${error.code}:', '${error.message}', null);
    } catch (error) {
      return new Response(false, '${error.toString()}:', error.toString(), null);
    }
  }

  Future<List<Menu>> list() async {
    return await firestore.collection("modifiers").get().then((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        List<ItemModifier> marks = [];
        List<dynamic> markMap = doc.data()['list'];
        markMap.forEach((element) {
          marks.add(new ItemModifier(element['name'], double.parse(element['price'].toString()), null));
        });

        return Menu(
          doc.data()['title'] ?? '',
          marks,
          doc.id,
        );
      }).toList();
    });
  }
}
