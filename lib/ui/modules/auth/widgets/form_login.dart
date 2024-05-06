import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';
import 'package:manager_projects_app/infrastructure/repositories/auth_repository.dart';
import 'package:manager_projects_app/infrastructure/repositories/user_repository.dart';
import 'package:manager_projects_app/infrastructure/repositories_local/user_local_repository.dart';
import 'package:manager_projects_app/ui/widgets/snack_bart_custom.dart';
import 'package:manager_projects_app/ui/widgets/form_widget.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

class FormLogin extends StatefulWidget {
  final void Function(bool value) onChangeForm;
  const FormLogin({super.key, required this.onChangeForm});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool _obscureText = true;
  bool isLoadingApp = false;
  bool isOkAuth = true;

  final _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadInitial();
  }

  loadInitial() {}

  checkUserAuth() async {
    if (!_formKeyLogin.currentState!.validate()) return;
    try {
      setState(() {
        isLoadingApp = true;
      });
      final email = emailController.text.toString().toLowerCase().trim();
      final password = passwordController.text.toString().trim();
      final response = await AuthRepository.authUserEmailAndPassword( email: email, password: password);

      if (!response.success) {
        showMessageErrorHandle(response.message);
        return;
      }
      final user = await UserRepository.getUserUid(response.data?.user?.uid ?? "123456789");
       log(user.message);
      if(user.data == null){ showMessageErrorHandle(user.message);
        return;
      }
      saveUser(user.data!);
    } catch (e, track) {
      log(track.toString());
      showMessageErrorHandle("Error intente mas tarde");
    } finally {
      setState(() {
        isLoadingApp = false;
      });
    }
  }

  saveUser(UserApp user)async{
    await UserLocalRepository.saveUser(userApp: user);
    navigateHome();
  }

  showMessageErrorHandle(String messageError) {
    showSnackBarMessageError(context, messageError);
  }

  navigateHome() {
    Navigator.pushReplacementNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKeyLogin,
        ///autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              sizedBoxHeightSmall(),
              Text('Ingresar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: isLoadingApp ? Colors.grey : Colors.black),
                  textAlign: TextAlign.center),
              sizedBoxHeightMedium(),
              TextFormField(
                enabled: !isLoadingApp,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Por favor, ingrese un email válido';
                  }
                  return null;
                },
                decoration: inputDecoration(hintText: 'Email'),
              ),
              sizedBoxHeightSmall(),
              TextFormField(
                enabled: !isLoadingApp,
                obscureText: _obscureText,
                keyboardType: TextInputType.text,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese contraseña';
                  }
                  return null;
                },
                decoration: inputDecoration(
                    hintText: 'Contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )),
              ),
              sizedBoxHeightMedium(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: !isLoadingApp ? () => checkUserAuth() : null,
                  child: isLoadingApp
                      ? const CircularProgressIndicator(
                          color: AppColors.contentColorWhite)
                      : const Text('Ingresar')),
              sizedBoxHeightSmall(),
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () => widget.onChangeForm(false),
                  child: const Text("¿Aun no tienes una cuenta? Registrarse"))
            ],
          ),
        ));
  }
}
