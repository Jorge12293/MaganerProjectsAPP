import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorMessage {
  static String handleError(FirebaseAuthException error) {
    String errorMessage = "An error occurred";
    log(error.code);
    switch (error.code) {
      case 'invalid-email':
        errorMessage = "La dirección de correo electrónico es incorrecta";
        break;
      case 'invalid-credential':
        errorMessage = "Credenciales inválidas";
        break;
      case 'user-not-found':
        errorMessage = "Usuario no encontrado";
        break;
      case 'wrong-password':
        errorMessage = "Contraseña incorrecta";
        break;
      case 'weak-password':
        errorMessage = "La contraseña debe ser mayor a 6 caracteres";
        break;
      case 'email-already-in-use':
        errorMessage = "El email ya se encuentra registrado";
        break;
      case 'network-request-failed':
        errorMessage = "Revisar conexión de internet";
        break;
      case 'user-disabled':
        errorMessage = "El usuario ha sido inhabilitado";
        break;
      case 'email-already-in-use':
        errorMessage = "El email ya esta en uso";
        break;
      default:
        errorMessage = "Ocurrió un error inesperado. Por favor, intenta de nuevo más tarde. Error : ${error.code} ${error.message}";

        break;
    }
    return errorMessage;
  }
}
