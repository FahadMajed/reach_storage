import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach_storage/reach_storage.dart';

final storagePvdr =
    StateNotifierProvider<StorageNotifier, AsyncValue<String>>((ref) {
  return StorageNotifier(
      ref.read(storageRepoPvdr), ref.watch(imageFilePvdr).value);
});
