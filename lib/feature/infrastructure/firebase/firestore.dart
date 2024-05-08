import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  Firestore._();

  static DocumentReference<Map<String, dynamic>> get version =>
      FirebaseFirestore.instance.collection('versions').doc('0.0.1');

  static CollectionReference<Map<String, dynamic>> get user =>
      version.collection('users');

  static CollectionReference<Map<String, dynamic>> get article =>
      version.collection('articles');

  static CollectionReference<Map<String, dynamic>> get favorite =>
      version.collection('favorites');

  static CollectionReference<Map<String, dynamic>> get comment =>
      version.collection('comments');

  static CollectionReference<Map<String, dynamic>> get report =>
      version.collection('report');

  static CollectionReference<Map<String, dynamic>> get follow =>
      version.collection('follows');
}
