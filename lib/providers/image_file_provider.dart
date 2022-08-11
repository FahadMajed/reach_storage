import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach_storage/notifiers/image_notifier.dart';

final imageFilePvdr = StateNotifierProvider<ImageNotifier, AsyncValue<File?>>(
    (ref) => ImageNotifier());
