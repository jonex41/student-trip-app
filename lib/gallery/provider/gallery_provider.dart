import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_project/data/models/my_images.dart';

final imageProvider = FutureProvider<List<MyImage>>((ref) async {
  return ref.watch(repo).getImages();
});


final repo = Provider<Repository>((ref) {
  return Repository() ;
});

class Repository {
  Future<List<MyImage>> getImages() async {
    var list = <MyImage>[];

    final storageRef = FirebaseStorage.instance.ref().child("gallery");
    final listResult = await storageRef.listAll();
    for (var prefix in listResult.prefixes) {
      // The prefixes under storageRef.
      // You can call listAll() recursively on them.
    }
    for (var item in listResult.items) {
      // The items under storageRef.
      list.add(MyImage(name: item.name, link: await item.getDownloadURL()));
    }
    return Future.value(list);
  }
}
