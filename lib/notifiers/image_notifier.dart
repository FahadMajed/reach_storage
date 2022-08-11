import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageNotifier extends StateNotifier<AsyncValue<File?>> {
  final ImagePicker _imagePicker = ImagePicker();

  ImageNotifier() : super(const AsyncData(null));

  Future<void> pickImage(ImageSource source) async {
    try {
      _imagePicker
          .pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
      )
          .then(
        (imageFile) async {
          if (imageFile != null) {
            await _cropImage(imageFile);
          }
        },
      );
    } catch (e, t) {
      state = AsyncError(e, stackTrace: t);
    }
  }

  Future<void> _cropImage(XFile imageFile) async {
    final file = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        maxWidth: 512,
        maxHeight: 512,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.original]);

    if (file != null) {
      state = AsyncData(file);
    }
  }
}
