import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage storage;

  StorageRepository(this.storage);

  Future<String> uploadImageFile(File imageFile, String filePath) async {
    final ref = storage.ref().child(filePath);
    return ref.putFile(imageFile).then(
      (taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          return await ref.getDownloadURL();
        }
        return "";
      },
    );
  }
}
