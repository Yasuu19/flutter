// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
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
    apiKey: 'AIzaSyBy1aA0eTDtySQN868hR5qAXcKh4P9ac08',
    appId: '1:688524084068:web:9408b681716e8f94573071',
    messagingSenderId: '688524084068',
    projectId: 'flutter-55cd3',
    authDomain: 'flutter-55cd3.firebaseapp.com',
    storageBucket: 'flutter-55cd3.appspot.com',
    measurementId: 'G-XP0996948G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTNTzclYfbSoL2-oQY4LzKQ9HxOEbvJp8',
    appId: '1:688524084068:android:6e4ff66d18c828f3573071',
    messagingSenderId: '688524084068',
    projectId: 'flutter-55cd3',
    storageBucket: 'flutter-55cd3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6mrbHsJ3NQbERyiX8hZv5mmP8ebbIB_4',
    appId: '1:688524084068:ios:67d102bc90ab001a573071',
    messagingSenderId: '688524084068',
    projectId: 'flutter-55cd3',
    storageBucket: 'flutter-55cd3.appspot.com',
    iosClientId: '688524084068-ndlvugsoq4qq4eudrr83a7t2jgvr2i36.apps.googleusercontent.com',
    iosBundleId: 'com.example.ipssiBd232',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6mrbHsJ3NQbERyiX8hZv5mmP8ebbIB_4',
    appId: '1:688524084068:ios:67d102bc90ab001a573071',
    messagingSenderId: '688524084068',
    projectId: 'flutter-55cd3',
    storageBucket: 'flutter-55cd3.appspot.com',
    iosClientId: '688524084068-ndlvugsoq4qq4eudrr83a7t2jgvr2i36.apps.googleusercontent.com',
    iosBundleId: 'com.example.ipssiBd232',
  );
}