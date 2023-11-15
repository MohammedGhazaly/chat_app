import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  bool isRegistering = false;
  Future<void> firebaseRegister(
      {required String email, required String password}) async {
    try {
      isRegistering = true;
      notifyListeners();
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // Show success
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        // Show error
      } else if (e.code == "email-already-in-use") {
        // Show error
      }
    } catch (e) {}

    isRegistering = false;
    notifyListeners();
  }
}
