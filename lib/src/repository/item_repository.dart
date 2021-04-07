import 'package:client_delivery_app/src/bloc/item/item_event.dart';
import 'package:client_delivery_app/src/model/item.dart';
import 'package:client_delivery_app/src/model/itemModifier.dart';
import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:client_delivery_app/src/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Response> add(AddItem event) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference modifiersRef = firestore.collection('companies');

    try {
      await modifiersRef.doc('${auth.currentUser.uid}').collection('items').add(event.item.toMap());
      return new Response(true, '', 'success', null);
    } on FirebaseAuthException catch (error) {
      return new Response(false, '${error.code}:', '${error.message}', null);
    } catch (error) {
      return new Response(false, '${error.toString()}:', error.toString(), null);
    }
  }

  Future<List<Item>> list() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    return await firestore.collection("companies").doc('${auth.currentUser.uid}').collection('items').get().then((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        List<ItemModifier> marks = [];
        List<dynamic> markMap = doc.data()['list'];
        markMap.forEach((element) {
          marks.add(new ItemModifier(element['name'], double.parse(element['price'].toString()), null));
        });

        return Item(
          doc.data()['title'] ?? '',
          marks,
          doc.id,
        );
      }).toList();
    });
  }
}
