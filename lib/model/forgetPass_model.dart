import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  static Future<bool> isEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;
    return user?.emailVerified ?? false;
  }
}