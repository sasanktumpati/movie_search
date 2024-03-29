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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiFgVJqLVrZqoordel04KwSGGp416qs7g',
    appId: '1:564332808749:android:6fba2c6ce260ec3fd386a4',
    messagingSenderId: '564332808749',
    projectId: 'movie-search-77ba5',
    storageBucket: 'movie-search-77ba5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBm2fZaul2dPxmZv2s7wcaTw1olCLok7Vw',
    appId: '1:564332808749:ios:fc30b975a088a79fd386a4',
    messagingSenderId: '564332808749',
    projectId: 'movie-search-77ba5',
    storageBucket: 'movie-search-77ba5.appspot.com',
    androidClientId:
        '564332808749-tko8fn4p7mpjt75lllhqj8lq784i9ta8.apps.googleusercontent.com',
    iosClientId:
        '564332808749-bu18c66g5bdnlsp7hqqcfgiohgv4irqk.apps.googleusercontent.com',
    iosBundleId: 'com.sasanktumpati.movieSearch',
  );
}
