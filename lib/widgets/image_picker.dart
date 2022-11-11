// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reach_core/core/core.dart';
import 'package:reach_storage/controllers/controllers.dart';

class ImagePickerContainer extends StatelessWidget {
  final DecorationType decorationType;
  final String imageUrl;
  final ImagePickerController controller = ImagePickerController();

  ///will be triggered when new file is uploaded, with the file as parameter
  final void Function(File) onImagePicked;

  ImagePickerContainer({
    Key? key,
    required this.imageUrl,
    required this.onImagePicked,
    this.decorationType = DecorationType.register,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => ActionSheet.show(
        actions: {
          "Photo Library": () async => await controller.pickImage(ImageSource.gallery).then((file) => _postPick(file)),
          "Camera": () async => await controller.pickImage(ImageSource.camera).then((file) => _postPick(file)),
        },
      ),
      child: Center(
        child: ClipOval(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 96, maxWidth: 96, minHeight: 94, minWidth: 94),
            child: Container(
              decoration: _getBoxDecoration(),
              child: Align(
                widthFactor: 1,
                heightFactor: 1,
                child: (imageUrl.isNotEmpty)
                    ? Avatar(
                        link: imageUrl,
                      )
                    : decorationType == DecorationType.register
                        ? const Text("pick photo")
                        : const EmptyAvatar(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _postPick(File? file) {
    if (file != null) onImagePicked(file);
    Get.close(1);
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black, width: 0.5),
      gradient: decorationType == DecorationType.register ? _getLinearGradient() : null,
    );
  }

  LinearGradient _getLinearGradient() {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.mirror,
      colors: [Colors.white, Colors.white, selectedColor],
    );
  }
}

enum DecorationType { register, profile }
