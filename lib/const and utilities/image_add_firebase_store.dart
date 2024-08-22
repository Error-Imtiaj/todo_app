import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final userId = FirebaseAuth.instance.currentUser?.uid;

class StoreImage {
  Future<String> uploadImageToStorage(String filename, Uint8List file) async {
    Reference ref = storage.ref().child(filename);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  Future<String> SaveiMAGE(
      {required Uint8List file, required email, required username}) async {
    String resp = 'some error occurs';
    try {
      String ImgUrl =
          await uploadImageToStorage('${userId}-ProfileImage', file);
      await firestore
          .collection('users')
          .doc(userId)
          .collection('Profiledetails')
          .add({
        "Fullname": "${userId}",
        "Imagelink": ImgUrl,
        "Email": "${email}",
      });
      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  Future<String?> getImageUrl() async {
    try {
      var documentSnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('Profiledetails')
          .orderBy('Imagelink', descending: true)
          .limit(1)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs.first['Imagelink'] as String?;
      }
    } catch (err) {
      print("Error fetching image URL: $err");
    }
    return null;
  }
}
