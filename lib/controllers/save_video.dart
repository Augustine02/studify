import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData{
  Future<String> uploadVideo(String videoUrl) async{
    Reference ref = _storage.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoUrl));
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> saveVideoData(String videoDownloadUrl)async{
    await _firestore.collection('video').add({
      'url' : videoDownloadUrl,
      'timeStamp' : FieldValue.serverTimestamp(),
      'name' : 'Lecture Video'

    });
  }
}