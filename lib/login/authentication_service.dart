import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  //connection to firebase authentication
  final FirebaseAuth _firebaseAuth;

  //constructor for _firebaseAuth
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  //sign out feature
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //sign in feature
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //sign up feature
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
