import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


abstract class DbStorage {
  Future<String> uploadFile(String userID, String fileType, File image);
}


class FirestoreStorageService implements DbStorage {


  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageReference;



  @override
  Future<String> uploadFile(String userID, String fileType, File image)async {
  _storageReference = _firebaseStorage.ref().child(userID).child(fileType).child("profil_foto.png");
  var uploadImage = _storageReference.putFile(image);

  var url = await (await uploadImage.onComplete).ref.getDownloadURL();


    return url;
  }


}