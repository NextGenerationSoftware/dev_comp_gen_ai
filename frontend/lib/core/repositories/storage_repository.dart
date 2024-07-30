import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  static String bucketLink = "gs://gc2024-430107.appspot.com";
  static String bucketLinkAutodelete = "gs://autodelete1";

  static Future<String?> uploadAndGetUrl(dynamic blob, String path,
      {bool autodelete = false}) async {
    // upload a file and get a public url
    String? publicUrl;
    try {
      await FirebaseStorage.instance
          .refFromURL(autodelete
              ? StorageRepository.bucketLinkAutodelete
              : StorageRepository.bucketLink)
          .child(path)
          .putData(blob, SettableMetadata(contentType: 'image/png'));
      publicUrl = await FirebaseStorage.instance
          .refFromURL(autodelete
              ? StorageRepository.bucketLinkAutodelete
              : StorageRepository.bucketLink)
          .child(path)
          .getDownloadURL();
    } catch (e) {
      log(e.toString());
    }
    return publicUrl;
  }
}
