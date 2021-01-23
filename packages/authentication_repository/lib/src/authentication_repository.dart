import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<bool> isAuthenticated() {
    return auth.authStateChanges().map<bool>((user) => user != null);
  }

  Future<String> signUp(String email, String password) async {
    String uid;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      uid = userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return uid;
  }

  Future<User> signIn(String email, String password) async {
    User user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return user;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> deleteUser() async {
    await FirebaseAuth.instance.currentUser.delete();
  }
}
