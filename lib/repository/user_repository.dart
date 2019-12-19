import 'package:tagchat/authentication.dart';
import 'package:tagchat/locator.dart';
import 'package:tagchat/model/user.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements Auth {
  Auth _firebaseAuth = locator<Auth>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<User> getCurrentUser() async {
    if (appMode == AppMode.RELEASE) {
      return await _firebaseAuth.getCurrentUser();
    }
    return null;
  }

  @override
  Future<bool> isEmailVerified() {
    return null;
  }

  @override
  Future<void> sendEmailVerification() {
    return null;
  }

  @override
  Future<User> signIn(String email, String password) async {
    if (appMode == AppMode.RELEASE) {
      return await _firebaseAuth.signIn(email, password);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    if (appMode == AppMode.RELEASE) {
      return await _firebaseAuth.signOut();
    } else {
      //başka bir veritabanı için alternatif

    }
  }

  @override
  Future<User> signUp(String email, String password) async {
    if (appMode == AppMode.RELEASE) {
      return await _firebaseAuth.signUp(email, password);
    }
    return null;
  }
}
