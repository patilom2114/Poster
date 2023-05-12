import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/post.dart';

import 'package:instagram_flutter/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //uplat post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
    
  ) async{
    String res= "Some Error Occured";
    try{
      //upload post

      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);
      //get post url

      String postId = const Uuid().v1();
      Post post =Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );

      _firestore.collection('posts').doc(postId).set(post.toJson(),);

      res = "Success";
    }catch(err){
        res = err.toString();

    }
    return res;
  }
}