import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_c/resources/storage_methods.dart';
import 'package:instagram_c/models/post.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String postId =
      const Uuid().v1(); //this will create the unique identifier each time

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = 'some error occured';
    try {
      //uploading the photo in the storage
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
