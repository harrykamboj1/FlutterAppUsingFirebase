import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/models/user.dart';
import 'package:firebase_flutter/services/database.dart';

class AuthService {
  // anonymous sign in
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object from firebaseUser
  UserModel? _userFromFirebase(User? user) {
    if (user != null) {
      return UserModel(user.uid);
    } else {
      return null;
    }
  }

  // auth change user stream
  Stream<UserModel?> get userStream {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user));
  }

  //sign in
  Future signInAnnoy() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  } //email password sign in

  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email
  Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new member', 100);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //signout

  Future signOut() async {
    try {
      print('sign out successful');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
