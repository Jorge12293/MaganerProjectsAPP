import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manager_projects_app/app.dart';
import 'package:manager_projects_app/firebase_options.dart';
import 'package:manager_projects_app/multiple_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: MultipleProviders.providers,
      child: const App(),
    )
  );
}
