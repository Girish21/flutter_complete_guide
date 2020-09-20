import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var isLoading = false;

  Future<void> _submitForm({
    @required String userName,
    @required String password,
    @required String emailId,
    @required bool isLogin,
    @required BuildContext context,
  }) async {
    final _auth = FirebaseAuth.instance;
    AuthResult _result;

    setState(() {
      isLoading = true;
    });

    try {
      if (isLogin) {
        _result = await _auth.signInWithEmailAndPassword(
          email: emailId,
          password: password,
        );
      } else {
        _result = await _auth.createUserWithEmailAndPassword(
          email: emailId,
          password: password,
        );

        await Firestore.instance
            .collection('users')
            .document(_result.user.uid)
            .setData(
          {
            'userName': userName,
            'emailId': emailId,
          },
        );
      }

      setState(() {
        isLoading = false;
      });
    } on PlatformException catch (error) {
      var message = 'Please check the provided credentials';

      if (error != null) {
        message = error.message;
      }

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(
        submitHandler: _submitForm,
        isLoading: isLoading,
      ),
    );
  }
}
