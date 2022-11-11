import 'dart:io';

import 'package:reach_core/core/core.dart';
import 'package:reach_storage/reach_storage.dart';

class StorageRepository {
  final FirebaseStorage storage;

  StorageRepository(this.storage);

  Future<String> uploadImageFile(File imageFile, String filePath) async {
    final ref = storage.ref().child(filePath);
    return ref.putFile(imageFile).then(
      (taskSnapshot) async {
        // if (taskSnapshot.state == TaskState.success) {
        return await ref.getDownloadURL();
        // }
        // return "";
      },
    );
  }
}

final storageRepoPvdr = Provider((ref) => StorageRepository(ref.read(storageServicePvdr)));
