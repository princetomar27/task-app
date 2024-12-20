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
    apiKey: 'AIzaSyCsCTJqgQ2qzXXljuN67ECJVWq9VMJg7Zg',
    appId: '1:613674118401:web:b63a94f3ee2628cd74ff00',
    messagingSenderId: '613674118401',
    projectId: 'todoapp-fefd7',
    authDomain: 'todoapp-fefd7.firebaseapp.com',
    storageBucket: 'todoapp-fefd7.firebasestorage.app',
    measurementId: 'G-HDGCY57V28',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjT61KXe1FeMDGH1VBWXPohk3vbP4Iug4',
    appId: '1:613674118401:android:63e3dc3eec46eaf074ff00',
    messagingSenderId: '613674118401',
    projectId: 'todoapp-fefd7',
    storageBucket: 'todoapp-fefd7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBv13Be1KEQfITvOtAtzxBCdl0-TGcXIH0',
    appId: '1:613674118401:ios:a6f016713bcc8b9474ff00',
    messagingSenderId: '613674118401',
    projectId: 'todoapp-fefd7',
    storageBucket: 'todoapp-fefd7.firebasestorage.app',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBv13Be1KEQfITvOtAtzxBCdl0-TGcXIH0',
    appId: '1:613674118401:ios:a6f016713bcc8b9474ff00',
    messagingSenderId: '613674118401',
    projectId: 'todoapp-fefd7',
    storageBucket: 'todoapp-fefd7.firebasestorage.app',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCsCTJqgQ2qzXXljuN67ECJVWq9VMJg7Zg',
    appId: '1:613674118401:web:ed33ff5626bee85274ff00',
    messagingSenderId: '613674118401',
    projectId: 'todoapp-fefd7',
    authDomain: 'todoapp-fefd7.firebaseapp.com',
    storageBucket: 'todoapp-fefd7.firebasestorage.app',
    measurementId: 'G-QTS4K0NDN8',
  );
}
