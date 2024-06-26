// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
            throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
                throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBVGVX-a8wgSEDlmi2ZI83NwcZJA0mcIgQ',
    appId: '1:546439151469:web:27c9071778a088a818a464',
    messagingSenderId: '546439151469',
    projectId: 'proyecto-pruebas-b4c26',
    authDomain: 'proyecto-pruebas-b4c26.firebaseapp.com',
    storageBucket: 'proyecto-pruebas-b4c26.appspot.com',
    measurementId: 'G-06FW4GY2VJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATsqm_W-jWLGWM3m1XqFb0NGCR8gh_Nsg',
    appId: '1:546439151469:android:6ca37d1740ace0da18a464',
    messagingSenderId: '546439151469',
    projectId: 'proyecto-pruebas-b4c26',
    storageBucket: 'proyecto-pruebas-b4c26.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvIcXv_eZAdr7nINVO5MdHxQVoIriEvdg',
    appId: '1:546439151469:ios:35e1557a5bb53c5918a464',
    messagingSenderId: '546439151469',
    projectId: 'proyecto-pruebas-b4c26',
    storageBucket: 'proyecto-pruebas-b4c26.appspot.com',
    iosClientId: '546439151469-sje0d9kmls96d0ibbc3vmm1airner33k.apps.googleusercontent.com',
    iosBundleId: 'com.example.managerProjectsApp',
  );


}