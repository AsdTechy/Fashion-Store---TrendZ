
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyCdXYBiaH_1SmjAtXaSRzT1bVj_QGL1Nz8',
    appId: '1:286355878091:web:3abb6c17b933176b762b4e',
    messagingSenderId: '286355878091',
    projectId: 'trenzproject',
    authDomain: 'trenzproject.firebaseapp.com',
    storageBucket: 'trenzproject.firebasestorage.app',
    measurementId: 'G-JJX12JE402',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjR3K1qgC-79uOYFrengkGvmca8fSU00A',
    appId: '1:286355878091:android:6a330ad6c8b827fc762b4e',
    messagingSenderId: '286355878091',
    projectId: 'trenzproject',
    storageBucket: 'trenzproject.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATnXGatJ3Y4NDipV51ZfqnWBC1EbveBEA',
    appId: '1:286355878091:ios:dec001c7b17689c5762b4e',
    messagingSenderId: '286355878091',
    projectId: 'trenzproject',
    storageBucket: 'trenzproject.firebasestorage.app',
    iosClientId: '286355878091-ecd1nofah5f7ubmi9m5smibnbbldtfkn.apps.googleusercontent.com',
    iosBundleId: 'com.example.fashionStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyATnXGatJ3Y4NDipV51ZfqnWBC1EbveBEA',
    appId: '1:286355878091:ios:dec001c7b17689c5762b4e',
    messagingSenderId: '286355878091',
    projectId: 'trenzproject',
    storageBucket: 'trenzproject.firebasestorage.app',
    iosClientId: '286355878091-ecd1nofah5f7ubmi9m5smibnbbldtfkn.apps.googleusercontent.com',
    iosBundleId: 'com.example.fashionStore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCdXYBiaH_1SmjAtXaSRzT1bVj_QGL1Nz8',
    appId: '1:286355878091:web:9f77d0a74d97751e762b4e',
    messagingSenderId: '286355878091',
    projectId: 'trenzproject',
    authDomain: 'trenzproject.firebaseapp.com',
    storageBucket: 'trenzproject.firebasestorage.app',
    measurementId: 'G-ZVWVJSK7YB',
  );

}