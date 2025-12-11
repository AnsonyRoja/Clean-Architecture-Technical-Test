import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';

class ArticleRemoteDataSourceFB {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ArticleRemoteDataSourceFB({
    required this.firestore,
    required this.storage,
  });

  /// Subir imagen al storage
  Future<String> uploadImage(File image) async {
    final ref = storage
        .ref()
        .child('media')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  /// Crear artículo en Firestore
  Future<void> createArticle(
    ArticleEntity article,
  ) async {
    print('Imagen seleccionada ');
    String imagenUrl = "Sin Imagen";
    if (article.slImg != null) {
      imagenUrl = await uploadImage(article.slImg!);
    }

    final docRef = firestore.collection("articles").doc();

    await docRef.set({
      "id": docRef.id,
      "authorId": 1,
      "title": article.title,
      "description": article.description ?? "",
      "publishedAt": FieldValue.serverTimestamp(),
      "urlToImage": imagenUrl,
    });
  }
}
