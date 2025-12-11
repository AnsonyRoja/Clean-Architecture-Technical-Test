// lib/core/firebase/firebase_initializer.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseInitializer {
  static Future<void> initialize({bool useEmulator = false}) async {
    // Inicializa Firebase
    await Firebase.initializeApp();

    if (useEmulator) {
      // Configuración del host local para Firestore
      FirebaseFirestore.instance.useFirestoreEmulator('192.168.0.103', 3002);

      FirebaseStorage.instance.useStorageEmulator('192.168.0.103', 3001);

      print("Se inicializaron los servicios de fiebase");
    }
  }
}
