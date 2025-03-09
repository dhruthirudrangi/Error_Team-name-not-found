import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signup Method
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null; // Success, no error message
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  // Login Method
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success, no error
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  // Logout Method
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
