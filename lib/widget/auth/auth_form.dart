import 'package:flutter/material.dart';

import 'dart:io';
import 'package:firebase_chat/widget/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final Function(String email, String username, String password, File image, bool isLogin,
      BuildContext ctx) submitFn;

  const AuthForm({super.key, required this.submitFn, required this.isLoading});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File? _userImage;

  void _selectedImage(File incomingImage) {
    _userImage = incomingImage;
  }

  // final BuildContext
  void _trySubmit() async {
    if (_userImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: const Text("Please select an image"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState?.save();
      await widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImage!,
        _isLogin,
        context,
      );
      // Use those values to send our auth request ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(pickImageFn: _selectedImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  const SizedBox(height: 12),
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Signup'),
                        ),
                  TextButton(
                    // textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
