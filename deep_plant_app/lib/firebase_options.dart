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
    apiKey: 'AIzaSyC5jW9_1rq1VlBapU4kZqLf1OG40autdRo',
    appId: '1:214163390785:web:635f7ebc63fa7b4c66e1c0',
    messagingSenderId: '214163390785',
    projectId: 'deepplant-e0416',
    authDomain: 'deepplant-e0416.firebaseapp.com',
    storageBucket: 'deepplant-e0416.appspot.com',
    measurementId: 'G-RFHBPXMFMV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxgTWcwRrgX8LUe3C7iMfurKcWdPwjdb0',
    appId: '1:214163390785:android:86838087df6d6a8b66e1c0',
    messagingSenderId: '214163390785',
    projectId: 'deepplant-e0416',
    storageBucket: 'deepplant-e0416.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNieA2Un-o6r8NvpJaMzlKyYLVk6fgX18',
    appId: '1:214163390785:ios:a1319a06a52db67b66e1c0',
    messagingSenderId: '214163390785',
    projectId: 'deepplant-e0416',
    storageBucket: 'deepplant-e0416.appspot.com',
    iosClientId: '214163390785-lktcqg2vdqo25ukvetvqest69s275roq.apps.googleusercontent.com',
    iosBundleId: 'com.example.deepPlantApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNieA2Un-o6r8NvpJaMzlKyYLVk6fgX18',
    appId: '1:214163390785:ios:484c283bf12e770a66e1c0',
    messagingSenderId: '214163390785',
    projectId: 'deepplant-e0416',
    storageBucket: 'deepplant-e0416.appspot.com',
    iosClientId: '214163390785-kuh80ek953o9jspl39p2h4glihqhbotm.apps.googleusercontent.com',
    iosBundleId: 'com.example.deepPlantApp.RunnerTests',
  );
}
