// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reach_core/core/core.dart';
import 'package:reach_storage/reach_storage.dart';

class ImagePickerContainer extends ConsumerWidget {
  final DecorationType decorationType;
  final String imageUrl;

  ///will be triggered when new file is uploaded, with the file url as parameter
  final void Function(String) whenData;

  const ImagePickerContainer({
    Key? key,
    required this.imageUrl,
    required this.whenData,
    this.decorationType = DecorationType.register,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageNotifier = ref.watch(imageFilePvdr.notifier);

    ref.listen<AsyncValue<String>>(
      storagePvdr,
      ((_, nextUrlAsync) {
        final nextUrl = nextUrlAsync.value ?? "";

        if (nextUrl.isNotEmpty && nextUrl != imageUrl) {
          whenData(nextUrl);
        }
      }),
    );

    return GestureDetector(
      onTap: () async => ActionSheetHandler.showActionSheet(
        actions: {
          "Photo Library": () async => await imageNotifier
              .pickImage(ImageSource.gallery)
              .then((_) => Get.close(1)),
          "Camera": () async => await imageNotifier
              .pickImage(ImageSource.camera)
              .then((_) => Get.close(1)),
        },
      ),
      child: Center(
        child: ClipOval(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxHeight: 96, maxWidth: 96, minHeight: 94, minWidth: 94),
            child: Container(
              decoration: _getBoxDecoration(),
              child: Align(
                widthFactor: 1,
                heightFactor: 1,
                child: ref.watch(storagePvdr).when(
                      data: (url) => (imageUrl.isNotEmpty)
                          ? Avatar(
                              link: imageUrl,
                            )
                          : decorationType == DecorationType.register
                              ? const Text("pick photo")
                              : const EmptyAvatar(),
                      error: (e, t) => throw e,
                      loading: () => const CircularProgressIndicator(),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black, width: 0.5),
      gradient: decorationType == DecorationType.register
          ? _getLinearGradient()
          : null,
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
