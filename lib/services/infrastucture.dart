import 'package:cloud_firestore/cloud_firestore.dart';

class InfrastructureService {
  CollectionReference users = FirebaseFirestore.instance.collection('infrastructure');

  static addInfrastructure() {

  }
}