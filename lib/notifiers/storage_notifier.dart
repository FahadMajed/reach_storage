import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach_storage/reach_storage.dart';

class StorageNotifier extends StateNotifier<AsyncValue<String>> {
  final Reader _read;
  late final StorageRepository _repository;
  final File? file;
  StorageNotifier(this._read, this.file) : super(const AsyncData("")) {
    _repository = _read(storageRepoPvdr);

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
