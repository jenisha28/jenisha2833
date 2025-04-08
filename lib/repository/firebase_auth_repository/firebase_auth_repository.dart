import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/model/users_model/users_model.dart';
import 'package:social_media_app/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:social_media_app/services/firestore_services/firestore_services.dart';

class FirebaseAuthRepository {
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
  final FirestoreServices _firestoreServices = FirestoreServices();

  Future<User?> registerUser(String email, String password, UsersModel usersModel) async {
    User? user = await _firebaseAuth.signUp(email, password);
    await _firestoreServices.addUser(usersModel);
    return user;
  }

  Future<User?> loginUser(String email, String password) async {
    User? user = await _firebaseAuth.signIn(email, password);
    return user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
