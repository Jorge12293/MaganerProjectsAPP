import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_projects_app/helpers/methods_firebase/authentication_error.dart';

class AuthService {
  static Future<UserCredential> authUserEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationError(e);
    }
  }

  static Future<UserCredential> authRegister(
      {required String email, required String password}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationError(e);
    }
  }

  static Future<User?> checkAuth() async {
    try {
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationError(e);
    }
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthenticationError(e);
    }
  }
}
