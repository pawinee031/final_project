import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/screens/admin/admin_main.dart';
import 'package:project/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../screens/home.dart';

class Auth {
  static String accessToken = 'accessToken';

  static Future<void> signUpWithEmail({
    required String email,
    required String password,
    required int age,
    required String birthdate,
    required String mobileNo,
    String firstName = "",
    String lastName = "",
  }) async {
    print(email);
    print(password);
    print(firstName);
    print(lastName);
    try {
      EasyLoading.show(status: "Regist");
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final String? token = await userCredential.user?.getIdToken();
      await FirestoreActions().createUser({
        "token": token,
        "uid": userCredential.user?.uid,
        "email": userCredential.user?.email,
        "first_name": firstName,
        "last_name": lastName,
        "birthdate": birthdate,
        "age": age,
        "mobileNo": mobileNo,
      });
      EasyLoading.dismiss();
    } catch (err) {
      print(err);
      EasyLoading.dismiss();
    }
  }

  static signInWithEmailPassword(context, String email, String password) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      EasyLoading.show(status: "Log In");
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String credentialAccessToken = await userCredential.user!.getIdToken();

      var user =
          await FirestoreActions().getUserProfile(userCredential.user!.uid);
      print('user : $user');
      sp.setString(accessToken, credentialAccessToken);
      sp.setString('firstName', user['first_name']);
      sp.setString('lastName', user['last_name']);
      sp.setString('email', user['email']);
      sp.setString('uid', user['uid']);
      sp.setInt('isAdmin', user['role']);
      sp.setInt('age', user['age']);
      sp.setString('birthdate', user['birthdate']);
      sp.setString('mobileNo', user['mobileNo']);
      EasyLoading.dismiss();
      if (user['role'] == 1) {
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminMain(), // login admin success
            ),
            (route) => false);
      } else
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(), // login user success
            ),
            (route) => false);
    } catch (err) {
      EasyLoading.dismiss();
      print('$err');
    }
  }

  static signout(context) async {
    // remove token
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    // await sp.remove(accessToken);
    await sp.clear();
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
        (route) => false);
  }

  static isUserLogin() async {
    //check token
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString(accessToken) != null) {
      return true;
    } else {
      return false;
    }
  }
}
