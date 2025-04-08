import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/utils/uuid_util.dart';

class StorageServices {
  Future<String> uploadChatImages(var selectedFile) async {
    String imageUrl = '';

    if (selectedFile.isNotEmpty) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child('${UuidUtil.uuid}.jpg');

      await storageRef.putFile(File(selectedFile));
      imageUrl = await storageRef.getDownloadURL();
    }
    print(imageUrl);
    return imageUrl;
  }

  Future<List<String>> uploadPostImages(List selectedFile) async {
    List<String> imageUrl = [];

    if (selectedFile.isNotEmpty) {
      for (int i = 0; i < selectedFile.length; i++) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('post_images')
            .child('${UuidUtil.uuid}.jpg');

        await storageRef.putFile(selectedFile[i]);
        imageUrl.add(await storageRef.getDownloadURL());
      }
    }
    return imageUrl;
  }
}
