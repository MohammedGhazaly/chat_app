import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/features/auth/navigator/auth_navigator.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late AuthNavigator navigator;
  bool isLoging = false;
  Future<void> firebaseLogin(
      {required String email, required String password}) async {
    try {
      isLoging = true;
      notifyListeners();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      MyUser loggedUser = await FireStoreService.getFireStoreUser(
          FirebaseAuth.instance.currentUser!.uid);
      await SharedPrefUtils.saveData(
          key: "userName", value: loggedUser.userName);
      navigator.navigate();

      // Show success
    } on FirebaseAuthException catch (e) {
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        navigator.showFailureDialog(
            title: "Error", desc: "Wrong email or password");
        // Show error
      }
    } catch (e) {}

    isLoging = false;
    notifyListeners();
  }
}
