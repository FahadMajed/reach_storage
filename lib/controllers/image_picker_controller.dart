import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController {
  final ImagePicker _imagePicker = ImagePicker();

  File? pickedImage;

  Future<File?> pickImage(ImageSource source) async {
    try {
      return _imagePicker
          .pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
      )
          .then(
        (imageFile) async {
          if (imageFile != null) {
            return await _cropImage(imageFile);
          }
          return null;
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> _cropImage(XFile imageFile) async =>
      await ImageCropper.cropImage(
          sourcePath: imageFile.path,
          maxWidth: 512,
          maxHeight: 512,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.original]);
}
