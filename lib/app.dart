import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/routes/app_routes.dart';
import 'package:manager_projects_app/ui/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Administrador',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: AppRoutes.initialRouteNotAuth,
      routes: AppRoutes.routes,
    );
  }
}


