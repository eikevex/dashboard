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
      apiKey: 'AIzaSyDfqs21hN2q87wm2wFQ-eK6wXAFA_1VHR0',
      appId: '1:522473045547:web:9780b336c96235388b346e',
      messagingSenderId: '522473045547',
      projectId: 'viacredi-fb02d',
      authDomain: 'viacredi-fb02d.firebaseapp.com',
      storageBucket: 'viacredi-fb02d.firebasestorage.app',
      measurementId: 'G-DEZKPB8W7Z',
    );

    static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyCKuG-4KzQuBDUgqUYRqvO0iSrCsxJnBbs',
      appId: '1:522473045547:android:b5281393ea2f88948b346e',
      messagingSenderId: '522473045547',
      projectId: 'viacredi-fb02d',
      storageBucket: 'viacredi-fb02d.firebasestorage.app',
    );

    static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'AIzaSyBAsoB3eUtN0rHzijC6JKLbRNXxPc4Jla8',
      appId: '1:522473045547:ios:f1184bffa97705be8b346e',
      messagingSenderId: '522473045547',
      projectId: 'viacredi-fb02d',
      storageBucket: 'viacredi-fb02d.firebasestorage.app',
      iosBundleId: 'com.example.dashborad',
    );

    static const FirebaseOptions macos = FirebaseOptions(
      apiKey: 'AIzaSyBAsoB3eUtN0rHzijC6JKLbRNXxPc4Jla8',
      appId: '1:522473045547:ios:f1184bffa97705be8b346e',
      messagingSenderId: '522473045547',
      projectId: 'viacredi-fb02d',
      storageBucket: 'viacredi-fb02d.firebasestorage.app',
      iosBundleId: 'com.example.dashborad',
    );

    static const FirebaseOptions windows = FirebaseOptions(
      apiKey: 'AIzaSyDfqs21hN2q87wm2wFQ-eK6wXAFA_1VHR0',
      appId: '1:522473045547:web:9a8657159ed35ee48b346e',
      messagingSenderId: '522473045547',
      projectId: 'viacredi-fb02d',
      authDomain: 'viacredi-fb02d.firebaseapp.com',
      storageBucket: 'viacredi-fb02d.firebasestorage.app',
      measurementId: 'G-FXD7Q5LYVX',
    );
  }
