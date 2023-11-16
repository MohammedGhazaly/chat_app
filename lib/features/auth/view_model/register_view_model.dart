import 'package:chat_app/data/my_user.dart';
import 'package:chat_app/features/auth/navigator/auth_navigator.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  late AuthNavigator navigator;
  bool isRegistering = false;
  Future<void> firebaseRegister(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      isRegistering = true;
      notifyListeners();
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      MyUser myUser =
          MyUser(id: result.user!.uid, email: email, userName: userName);

      await FireStoreService.saveUserToFireStore(myUser);

      navigator.showSuccessDialog(
          title: "Hooray!", desc: "Account created successfully");
      isRegistering = false;
      notifyListeners();

      // Show success
    } on FirebaseAuthException catch (e) {
      isRegistering = false;
      notifyListeners();
      if (e.code == "weak-password") {
        navigator.showFailureDialog(title: "Error", desc: "Password is weak");
        // Show error
      } else if (e.code == "email-already-in-use") {
        navigator.showFailureDialog(title: "Error", desc: "Email already used");
        // Show error
      }
    } catch (e) {}
  }
}
