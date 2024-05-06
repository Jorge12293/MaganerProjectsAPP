import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationError implements Exception {
  final FirebaseAuthException exception;
  AuthenticationError(this.exception);
}
