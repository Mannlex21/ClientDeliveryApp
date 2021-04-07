import 'package:client_delivery_app/src/model/companyType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyTypeRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<CompanyType>> getList() {
    return firestore.collection('settings').doc('companyType').collection('list').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CompanyType.fromSnapshot(doc)).toList();
    });
  }
}
