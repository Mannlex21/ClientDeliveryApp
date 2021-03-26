import 'package:client_delivery_app/src/model/CompanyType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyTypeRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<CompanyType>> getList() {
    return firestore.collection('companyType').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CompanyType.fromSnapshot(doc)).toList();
    });
  }
}
