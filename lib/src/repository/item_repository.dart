import 'package:client_delivery_app/src/bloc/item/item_event.dart';
import 'package:client_delivery_app/src/model/item.dart';
import 'package:client_delivery_app/src/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Response> add(AddItem event) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference modifiersRef = firestore.collection('companies');

    try {
      await modifiersRef
          .doc('${auth.currentUser.uid}')
          .collection('items')
          .add(event.item.toMap());
      return new Response(true, '', 'success', null);
    } on FirebaseAuthException catch (error) {
      return new Response(false, '${error.code}:', '${error.message}', null);
    } catch (error) {
      return new Response(
          false, '${error.toString()}:', error.toString(), null);
    }
  }

  Future<List<Item>> list() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    return await firestore
        .collection("companies")
        .doc('${auth.currentUser.uid}')
        .collection('items')
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        var date = DateTime.parse(doc.data()['lastUpdate'].toDate().toString());
        print(doc.data()['lastUpdate']);
        print(date);
        return Item(
          doc.data()['name'] ?? '',
          doc.data()['price'] ?? 0.0,
          new List<String>.from(doc.data()['menus']) ?? [],
          new List<String>.from(doc.data()['categories']) ?? [],
          new List<String>.from(doc.data()['usedIn']) ?? [],
          new List<String>.from(doc.data()['contains']) ?? [],
          DateTime.parse(doc.data()['lastUpdate'].toDate().toString()) ??
              DateTime.now(),
          doc.data()['isOutOfStock'] ?? false,
          doc.data()['isSellingItself'] ?? false,
        );
      }).toList();
    });
  }
}
