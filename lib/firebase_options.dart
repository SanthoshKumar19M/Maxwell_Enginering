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
    apiKey: 'AIzaSyAACptX8E0BVtRSuw8dIqAwSIlJ4QsT_yU',
    appId: '1:1093913485009:web:60b548db6e09c8119deff0',
    messagingSenderId: '1093913485009',
    projectId: 'maxwell-engineering',
    authDomain: 'maxwell-engineering.firebaseapp.com',
    storageBucket: 'maxwell-engineering.firebasestorage.app',
    measurementId: 'G-J5JPKJTK3H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdrq_bq8UOBs1KEcKP6atAH2bcf5ezlVs',
    appId: '1:1093913485009:android:7a0a3f2120aff2879deff0',
    messagingSenderId: '1093913485009',
    projectId: 'maxwell-engineering',
    storageBucket: 'maxwell-engineering.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzY-Q44InqDwUDLUpBGCTSo5_kKIHmM3c',
    appId: '1:1093913485009:ios:13972d5fb38815a39deff0',
    messagingSenderId: '1093913485009',
    projectId: 'maxwell-engineering',
    storageBucket: 'maxwell-engineering.firebasestorage.app',
    iosBundleId: 'com.example.maxwellengineering',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzY-Q44InqDwUDLUpBGCTSo5_kKIHmM3c',
    appId: '1:1093913485009:ios:13972d5fb38815a39deff0',
    messagingSenderId: '1093913485009',
    projectId: 'maxwell-engineering',
    storageBucket: 'maxwell-engineering.firebasestorage.app',
    iosBundleId: 'com.example.maxwellengineering',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAACptX8E0BVtRSuw8dIqAwSIlJ4QsT_yU',
    appId: '1:1093913485009:web:e91e41401a6cc6139deff0',
    messagingSenderId: '1093913485009',
    projectId: 'maxwell-engineering',
    authDomain: 'maxwell-engineering.firebaseapp.com',
    storageBucket: 'maxwell-engineering.firebasestorage.app',
    measurementId: 'G-NZL16D7WD9',
  );
}
