import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  CollectionReference profiles =
      FirebaseFirestore.instance.collection('profiles');

  Future<void> createProfile(
      {String uid, String name, int age, String gender}) {
    return profiles.doc(uid).set({'name': name, 'age': age, 'gender': gender});
  }

  Future<void> deleteProfile(String uid) {
    return profiles.doc(uid).delete();
  }

// Future<void> updateProfile(){}

// Future<void> retrieveProfile(){}

}
