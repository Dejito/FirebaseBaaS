import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth? auth = FirebaseAuth.instance;
  UserCredential? userCredential;

  void tryLogin(
      String email, String username, String password, bool isLogin, BuildContext ctx) async {
    try {
      print(isLogin);
      if (!isLogin) {
        userCredential = await auth?.createUserWithEmailAndPassword(
            email: email, password: password);
        print(userCredential);
      } else {
        userCredential = await auth?.signInWithEmailAndPassword(
            email: email, password: password);
        print(userCredential);
      }

    } on PlatformException catch (e) {
      String? message = "An error occurred. Please check your credentials";
      if (e.message != null) {
        message = e.message;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(message!),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitFn: tryLogin),
    );
  }
}
