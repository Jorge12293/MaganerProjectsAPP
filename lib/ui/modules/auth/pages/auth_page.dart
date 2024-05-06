import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/repositories/auth_repository.dart';
import 'package:manager_projects_app/ui/modules/auth/views/login_view.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoadApp = true;
  @override
  void initState() {
    super.initState();
    loadInitial();
  }

  loadInitial() async {
    try {
      final response = await AuthRepository.checkAuth();
      if (response.success && response.data != null) {
       navigateHome();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      stopLoadingApp();
    }
  }

  stopLoadingApp() {
    setState(() {
      isLoadApp = false;
    });
  }

  navigateHome() {
    Navigator.pushReplacementNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadApp) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return const Scaffold(
      body: LoginView(),
    );
  }
}
