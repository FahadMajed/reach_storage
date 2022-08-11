import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach_storage/reach_storage.dart';

class StorageNotifier extends StateNotifier<AsyncValue<String>> {
  final StorageRepository repository;
  final File? file;
  StorageNotifier(this.repository, this.file) : super(const AsyncData("")) {
    if (file != null) uploadImageFile(file!);
  }

  /// when success, returns the image url
  Future<void> uploadImageFile(File imageFile) async {
    state = const AsyncLoading();

    final filePath = 'images/${DateTime.now()}.png';

    state = AsyncData(await repository.uploadImageFile(imageFile, filePath));
  }
}
