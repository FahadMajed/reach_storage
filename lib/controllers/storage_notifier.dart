import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach_storage/reach_storage.dart';

final storagePvdr = StateNotifierProvider<StorageNotifier, AsyncValue<String>>(
    (ref) => StorageNotifier(
        ref.read(storageRepoPvdr), ref.watch(imageFilePvdr).value));

class StorageNotifier extends StateNotifier<AsyncValue<String>> {
  final StorageRepository _repository;
  final File? file;
  StorageNotifier(this._repository, this.file) : super(const AsyncData("")) {
    if (file != null) uploadImageFile(file!);
  }

  /// when success, returns the image url
  Future<String> uploadImageFile(File imageFile) async {
    state = const AsyncLoading();

    final filePath = 'images/${DateTime.now()}.png';

    state = AsyncData(await _repository.uploadImageFile(imageFile, filePath));
    return state.value ?? "";
  }
}
