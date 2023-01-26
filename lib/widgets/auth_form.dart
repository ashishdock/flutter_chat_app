import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  // const AuthForm({ Key? key }) : super(key: key);
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;
  AuthForm({this.submitFn, this.isLoading});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
      FocusScope.of(context).unfocus();

      //Use those values to send ur auth request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('userName'),
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value.isEmpty || (value.length < 4)) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) => _userName = newValue,
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || (value.length < 7)) {
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    onSaved: (newValue) => _userPassword = newValue,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'I already have an account',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
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
