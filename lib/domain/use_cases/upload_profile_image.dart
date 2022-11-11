import 'dart:io';

import 'package:reach_core/core/core.dart';
import 'package:reach_storage/reach_storage.dart';

class UploadProfileImage extends UseCase<String, File> {
  final StorageRepository repository;
  UploadProfileImage(this.repository);
  @override
  Future<String> call(file) async {
    final filePath = 'images/${DateTime.now()}.png';

    return await repository.uploadImageFile(file, filePath);
  }
}

final uploadProfileImagePvdr =
    Provider<UploadProfileImage>((ref) => UploadProfileImage(
          ref.read(storageRepoPvdr),
        ));
