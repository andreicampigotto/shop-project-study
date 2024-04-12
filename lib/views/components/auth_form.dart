// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { singUp, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isSingIn() => _authMode == AuthMode.login;
  bool _isSingUp() => _authMode == AuthMode.singUp;

  void _switchAuthMode() {
    setState(() {
      if (_isSingIn()) {
        _authMode = AuthMode.singUp;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An error has occurred'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isSingIn()) {
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await auth.singUp(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('An unexpected error occurred');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 8,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        height: deviceSize.height * 0.45,
        width: deviceSize.width * 0.88,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty ||
                        (!email.contains('@') && !email.contains('.com'))) {
                      return 'E-mail is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (password) =>
                        _authData['password'] = password ?? '',
                    obscureText: true,
                    controller: _passwordController,
                    validator: (_password) {
                      final password = _password ?? '';
                      if (password.isEmpty || password.length < 5) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    }),
                if (_isSingUp())
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirm password'),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: _isSingIn()
                        ? null
                        : (_password) {
                            final password = _password ?? '';
                            if (password != _passwordController.text ||
                                password.isEmpty) {
                              return "Passwords don't match";
                            }
                            return null;
                          },
                  ),
                const SizedBox(height: 24),
                if (_isLoading)
                  ElevatedButton(
                      onPressed: () {},
                      child: const CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8),
                    ),
                    child: Text(
                      _authMode == AuthMode.login ? 'Sing-In' : 'Sing-up',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    _isSingIn() ? 'Sing up' : 'Sing in',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            )),
      ),
    );
  }
}
