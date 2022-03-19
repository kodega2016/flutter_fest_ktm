import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitConfig {
  static FirebaseAuth getFirebaseAuthInstance() {
    return FirebaseAuth.instance;
  }

  static FirebaseFirestore getFirebaseFireStoreInstance() {
    return FirebaseFirestore.instance;
  }
}
