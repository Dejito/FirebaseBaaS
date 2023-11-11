import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth? auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  FirebaseFirestore? fireStore;
  bool _isLoading = false;

  void tryLogin(String email, String username, String password, bool isLogin,
      BuildContext ctx) async {

    try {
      setState(() {
        _isLoading = true;
      });
      if (!isLogin) {

        userCredential = await auth?.createUserWithEmailAndPassword(
            email: email, password: password);
        fireStore
            ?.collection('users')
            .doc(userCredential?.user?.uid)
            .set({'username': username});
        setState(() {
          _isLoading = false;
        });

      } else {
        userCredential = await auth?.signInWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          _isLoading = false;
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _isLoading = false;
      });
      String? message = "An error occurred. Please check your credentials";
      if (e.message != null) {
        message = e.message;
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(message!),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitFn: tryLogin, isLoading: _isLoading),
    );
  }
}
