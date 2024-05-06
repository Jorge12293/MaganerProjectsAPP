import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';
import 'package:manager_projects_app/infrastructure/repositories/auth_repository.dart';
import 'package:manager_projects_app/infrastructure/repositories/user_repository.dart';
import 'package:manager_projects_app/infrastructure/repositories_local/user_local_repository.dart';
import 'package:manager_projects_app/ui/widgets/snack_bart_custom.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';
import 'package:manager_projects_app/ui/widgets/form_widget.dart';

class FormRegister extends StatefulWidget {
  final void Function(bool value) onChangeForm;
  const FormRegister({super.key, required this.onChangeForm});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool isLoadingApp = false;
  bool isOkAuth = true;

  final _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  checkUserRegister() async {
    if (!_formKeyLogin.currentState!.validate()) return;
    try {
      setState(() {
        isLoadingApp = true;
      });
      final userName = userNameController.text.toString().trim();
      final email = emailController.text.toString().toLowerCase().trim();
      final password = passwordController.text.toString().trim();
      final response =  await AuthRepository.authRegister(email: email, password: password);
      if (!response.success) {
        showMessageErrorHandle(response.message);
        return;
      }
      if (response.data?.user?.uid == null) {
        showMessageErrorHandle("Error intente mas tarde");
        return;
      }
     // log(response.data?.user?.uid ?? "UID=0");
      final dataUser = await  UserRepository.addUser(UserApp(
          uid:response.data?.user?.uid ?? "",
          username: userName,
          email: email));
      log(dataUser.message); 
      if(dataUser.data == null){
         showMessageErrorHandle("Error intente mas tarde");
        return;
      }    
     saveUser(dataUser.data!);
 
    } catch (e, track) {
      log(e.toString());
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
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sizedBoxHeightSmall(),
              Text('Registrarse',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: isLoadingApp ? Colors.grey : Colors.black),
                  textAlign: TextAlign.center),
              sizedBoxHeightMedium(),
              TextFormField(
                enabled: !isLoadingApp,
                keyboardType: TextInputType.text,
                controller: userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese Usuario';
                  }

                  return null;
                },
                decoration: inputDecoration(hintText: 'Usuario'),
              ),
              sizedBoxHeightSmall(),
              TextFormField(
                enabled: !isLoadingApp,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresar Email';
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
                  if (value.length <= 6) {
                    return 'Por favor, la contraseña debe ser mayor a 6 caracteres';
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
              sizedBoxHeightSmall(),
              TextFormField(
                enabled: !isLoadingApp,
                obscureText: _obscureText2,
                keyboardType: TextInputType.text,
                controller: passwordRepeatController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese contraseña';
                  }
                  if (passwordRepeatController.text.trim() !=
                      passwordController.text.trim()) {
                    return 'Debe ingresar la misma contraseña';
                  }
                  return null;
                },
                decoration: inputDecoration(
                    hintText: 'Repetir Contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText2
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                    )),
              ),
              sizedBoxHeightMedium(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: !isLoadingApp ? () => checkUserRegister() : null,
                  child: isLoadingApp
                      ? const CircularProgressIndicator(
                          color: AppColors.contentColorWhite)
                      : const Text('Registrar')),
              sizedBoxHeightSmall(),
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () => widget.onChangeForm(true),
                  child: Text("¿Ya tienes una cuenta? Ingresar"))
            ],
          ),
        ));
  }
}
