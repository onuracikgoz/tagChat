import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tagchat/model/user.dart';

abstract class DBBase {
  Future<bool> saveUser (User user);

}


class FirestoreDBService implements DBBase {

  Firestore _firebaseUserSave = Firestore.instance;
  @override
  Future<bool> saveUser(User user) async{
    Map _userMap = user.toMap();
    _userMap['createdAt']= FieldValue.serverTimestamp();
    _userMap['updatedAt']= FieldValue.serverTimestamp(); 

    await _firebaseUserSave.collection('users').document(user.userID).setData(_userMap);
    return true;
  }


}



  
