import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach_storage/reach_storage.dart';

final storageServicePvdr = Provider((ref) => FirebaseStorage.instance);

final storageRepoPvdr =
    Provider((ref) => StorageRepository(ref.read(storageServicePvdr)));