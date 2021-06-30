import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../widgets/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String userName,
    String passWord,
    bool isLogin,
    BuildContext cxt,
  ) submitFn;
  final bool isLoaded;

  AuthForm(this.submitFn, this.isLoaded);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File pickedImage;

  void _pickedImage(File image) {
    pickedImage = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); // close the soft keyboard

    if (isValid != null) {
      _formKey.currentState.save(); // this will trigger on saved function
      widget.submitFn(
        _userEmail.trim(),
        _userName,
        _userPassword,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserImagePicker(_pickedImage),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Please enter password at least 7 Characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'User Name'),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  if(widget.isLoaded)
                    CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  if(!widget.isLoaded)
                  RaisedButton(
                    onPressed: _trySubmit,
                    child: Text('Login'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if(!widget.isLoaded)
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
