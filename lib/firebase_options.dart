import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default Firebase configuration for your app
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return web;
      case TargetPlatform.iOS:
        return web;
      case TargetPlatform.macOS:
        return web;
      case TargetPlatform.windows:
        return web;
      case TargetPlatform.linux:
        return web;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBb40P5i_RFx8yW2b6PhYgYX8QOaJemaEI",
    authDomain: "puzzle-app-cc89e.firebaseapp.com",
    projectId: "puzzle-app-cc89e",
    storageBucket: "puzzle-app-cc89e.firebasestorage.app",
    messagingSenderId: "308997369628",
    appId: "1:308997369628:web:bbdc54c3ad6d3df5c014d9",
    measurementId: "G-BWGEXZSG3N",
  );
}