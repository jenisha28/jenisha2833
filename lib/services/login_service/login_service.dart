import 'package:social_media_app/main.dart';

class LoginService {

  static Future login(String email, String password) async {
    await firebase.signInWithEmailAndPassword(
        email: email, password: password);
  }

}