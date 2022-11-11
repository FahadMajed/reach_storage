import 'package:firebase_storage/firebase_storage.dart';
import 'package:reach_core/lib.dart';
import 'package:reach_storage/reach_storage.dart';

final storageServicePvdr = Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
