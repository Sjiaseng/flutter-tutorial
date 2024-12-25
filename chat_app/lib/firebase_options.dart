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
    apiKey: 'keyhere',
    appId: '1:313522960496:web:3be03ddca165e4d3abdcb5',
    messagingSenderId: '313522960496',
    projectId: 'chat-app-fafc7',
    authDomain: 'chat-app-fafc7.firebaseapp.com',
    storageBucket: 'chat-app-fafc7.appspot.com',
    measurementId: 'G-H0Y1KSPCGJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'keyhere',
    appId: '1:313522960496:android:2048698ae8b0fcb2abdcb5',
    messagingSenderId: '313522960496',
    projectId: 'chat-app-fafc7',
    storageBucket: 'chat-app-fafc7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'keyhere',
    appId: '1:313522960496:ios:e3e2b6b22e8d9d98abdcb5',
    messagingSenderId: '313522960496',
    projectId: 'chat-app-fafc7',
    storageBucket: 'chat-app-fafc7.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'keyhere',
    appId: '1:313522960496:ios:e3e2b6b22e8d9d98abdcb5',
    messagingSenderId: '313522960496',
    projectId: 'chat-app-fafc7',
    storageBucket: 'chat-app-fafc7.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'keyhere',
    appId: '1:313522960496:web:943fe67b6c6d57fcabdcb5',
    messagingSenderId: '313522960496',
    projectId: 'chat-app-fafc7',
    authDomain: 'chat-app-fafc7.firebaseapp.com',
    storageBucket: 'chat-app-fafc7.appspot.com',
    measurementId: 'G-WNYJKBCX41',
  );
}
