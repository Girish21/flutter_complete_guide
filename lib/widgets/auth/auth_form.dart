import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;

  final Future<void> Function({
    @required String userName,
    @required String password,
    @required String emailId,
    @required bool isLogin,
    @required BuildContext context,
  }) submitHandler;

  const AuthForm({
    Key key,
    this.submitHandler,
    this.isLoading,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  Map<String, String> _formState = {};

  var _isLogin = true;

  Future<void> _trySubmit(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await widget.submitHandler(
        isLogin: _isLogin,
        emailId: _formState['email'],
        password: _formState['password'],
        userName: _formState['userName'],
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('userName'),
                      decoration: InputDecoration(
                        labelText: 'User Name',
                      ),
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter a user name';

                        return null;
                      },
                      onSaved: (newValue) {
                        _formState['userName'] = newValue.trim();
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@'))
                        return 'Enter a valid email address';

                      return null;
                    },
                    onSaved: (newValue) {
                      _formState['email'] = newValue.trim();
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 6)
                        return 'Password must be 6 characters long';

                      return null;
                    },
                    onSaved: (newValue) {
                      _formState['password'] = newValue.trim();
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  if (widget.isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: () {
                        _trySubmit(context);
                      },
                      child: Text(
                        _isLogin ? 'Login' : 'Signup',
                      ),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'Already have an account',
                      ),
                      textColor: Theme.of(context).primaryColor,
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
