import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/modules/auth/widgets/form_login.dart';
import 'package:manager_projects_app/ui/modules/auth/widgets/form_register.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLogin = true;

  void onChangeForm(bool value) {
    setState(() {
      isLogin = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double withScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Container(
      width: withScreen,
      height: heightScreen,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child:Padding(
              padding: const EdgeInsets.all(10),
              child: isLogin
                  ? FormLogin(
                      onChangeForm: (value) => onChangeForm(value))
                  : FormRegister(
                      onChangeForm: (value) => onChangeForm(value))),
      ),
    );
  }
}
