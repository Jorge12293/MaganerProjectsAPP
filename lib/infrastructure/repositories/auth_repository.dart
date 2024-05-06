import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_projects_app/data/firebase/auth_service.dart';
import 'package:manager_projects_app/helpers/methods_api/api_response.dart';
import 'package:manager_projects_app/helpers/methods_firebase/authentication_error.dart';
import 'package:manager_projects_app/helpers/methods_firebase/firebase_error_message.dart';

class AuthRepository {
  static Future<ApiResponse<UserCredential?>> authUserEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential user = await AuthService.authUserEmailAndPassword(
          email: email, password: password);
      return ApiResponse<UserCredential>(data: user);
    } catch (e) {
      if (e is AuthenticationError) {
        return ApiResponse(
            data: null,
            success: false,
            message: FirebaseErrorMessage.handleError(e.exception));
      } else {
        return ApiResponse(
            data: null,
            success: false,
            message: "Ocurrió un error intente más tarde");
      }
    }
  }

  static Future<ApiResponse<UserCredential?>> authRegister(
      {required String email, required String password}) async {
    try {
      UserCredential user =
          await AuthService.authRegister(email: email, password: password);
      return ApiResponse<UserCredential>(data: user);
    } catch (e) {
      if (e is AuthenticationError) {
        return ApiResponse(
            data: null,
            success: false,
            message: FirebaseErrorMessage.handleError(e.exception));
      } else {
        return ApiResponse(
            data: null,
            success: false,
            message: "Ocurrió un error intente más tarde");
      }
    }
  }

  static Future<ApiResponse<User?>> checkAuth() async {
    try {
      User? user = await AuthService.checkAuth();
      if (user != null) {
        return ApiResponse<User>(data: user);
      }
      return ApiResponse(
          data: null, success: false, message: "Usuario no encontrado");
    } catch (e) {
      if (e is AuthenticationError) {
        return ApiResponse(
            data: null,
            success: false,
            message: FirebaseErrorMessage.handleError(e.exception));
      } else {
        return ApiResponse(
            data: null,
            success: false,
            message: "Ocurrió un error intente más tarde");
      }
    }
  }

  static Future<ApiResponse<bool>> signOut() async {
    try {
      await AuthService.signOut();
      return ApiResponse<bool>(data: true);
    } catch (e) {
      if (e is AuthenticationError) {
        return ApiResponse(
            data: false,
            success: false,
            message: FirebaseErrorMessage.handleError(e.exception));
      } else {
        return ApiResponse(
            data: false,
            success: false,
            message: "Ocurrió un error intente más tarde");
      }
    }
  }
}
