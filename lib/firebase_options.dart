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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBQKboRVvrDBWkvotPPiKFZW6NeIHCG6dk',
    appId: '1:632674462438:web:9e900d1282338bf65de927',
    messagingSenderId: '632674462438',
    projectId: 'lawapp-f7d44',
    authDomain: 'lawapp-f7d44.firebaseapp.com',
    storageBucket: 'lawapp-f7d44.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDheEqcZso89WVx-tXlOs1QObtNE79LV4I',
    appId: '1:632674462438:android:1fcd727ffe82b9885de927',
    messagingSenderId: '632674462438',
    projectId: 'lawapp-f7d44',
    storageBucket: 'lawapp-f7d44.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyET_bcV8Tqq805VXi7R5zPciePkSrqAw',
    appId: '1:632674462438:ios:2c16e3559c341e955de927',
    messagingSenderId: '632674462438',
    projectId: 'lawapp-f7d44',
    storageBucket: 'lawapp-f7d44.appspot.com',
    iosBundleId: 'com.example.lawApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyET_bcV8Tqq805VXi7R5zPciePkSrqAw',
    appId: '1:632674462438:ios:2c16e3559c341e955de927',
    messagingSenderId: '632674462438',
    projectId: 'lawapp-f7d44',
    storageBucket: 'lawapp-f7d44.appspot.com',
    iosBundleId: 'com.example.lawApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBQKboRVvrDBWkvotPPiKFZW6NeIHCG6dk',
    appId: '1:632674462438:web:88df3caedc5e5b575de927',
    messagingSenderId: '632674462438',
    projectId: 'lawapp-f7d44',
    authDomain: 'lawapp-f7d44.firebaseapp.com',
    storageBucket: 'lawapp-f7d44.appspot.com',
  );
}
