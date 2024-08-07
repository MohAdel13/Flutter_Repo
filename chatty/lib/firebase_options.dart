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
    apiKey: 'AIzaSyCkfmZNfOfb6mzFd9Y7MU0vTmMmea4XMrE',
    appId: '1:900506661057:web:6c6ab7e13ace529f0d6440',
    messagingSenderId: '900506661057',
    projectId: 'chattyandroid-8f94e',
    authDomain: 'chattyandroid-8f94e.firebaseapp.com',
    databaseURL: 'https://chattyandroid-8f94e-default-rtdb.firebaseio.com',
    storageBucket: 'chattyandroid-8f94e.appspot.com',
    measurementId: 'G-RKRW87T6SB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfK7kLTbSwTWxuuH2vdSp9ej3Hwf7hOn4',
    appId: '1:900506661057:android:01c5754d9183ad5f0d6440',
    messagingSenderId: '900506661057',
    projectId: 'chattyandroid-8f94e',
    databaseURL: 'https://chattyandroid-8f94e-default-rtdb.firebaseio.com',
    storageBucket: 'chattyandroid-8f94e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHgYZ91AsYwedDlXlXYu32yT26v4yRjl0',
    appId: '1:900506661057:ios:f0a4dc42cc01c2a50d6440',
    messagingSenderId: '900506661057',
    projectId: 'chattyandroid-8f94e',
    databaseURL: 'https://chattyandroid-8f94e-default-rtdb.firebaseio.com',
    storageBucket: 'chattyandroid-8f94e.appspot.com',
    iosBundleId: 'com.example.chatty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHgYZ91AsYwedDlXlXYu32yT26v4yRjl0',
    appId: '1:900506661057:ios:f0a4dc42cc01c2a50d6440',
    messagingSenderId: '900506661057',
    projectId: 'chattyandroid-8f94e',
    databaseURL: 'https://chattyandroid-8f94e-default-rtdb.firebaseio.com',
    storageBucket: 'chattyandroid-8f94e.appspot.com',
    iosBundleId: 'com.example.chatty',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCkfmZNfOfb6mzFd9Y7MU0vTmMmea4XMrE',
    appId: '1:900506661057:web:50bcd14ce341173f0d6440',
    messagingSenderId: '900506661057',
    projectId: 'chattyandroid-8f94e',
    authDomain: 'chattyandroid-8f94e.firebaseapp.com',
    databaseURL: 'https://chattyandroid-8f94e-default-rtdb.firebaseio.com',
    storageBucket: 'chattyandroid-8f94e.appspot.com',
    measurementId: 'G-0GFJKJ3BS2',
  );
}
