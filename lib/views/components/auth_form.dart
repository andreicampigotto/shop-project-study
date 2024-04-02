import 'package:flutter/material.dart';

enum AuthMode { singup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final AuthMode _authMode = AuthMode.login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        height: 360,
        width: deviceSize.width * 0.88,
        child: Form(
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
                decoration: const InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (password) => _authData['password'] = password ?? '',
                obscureText: true,
                controller: _passwordController,
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty || password.length < 5) {
                    return 'Please enter a valid password';
                  }
                  return null;
                }),
            if (_authMode == AuthMode.singup)
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Confirm password'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _authMode == AuthMode.login
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              ),
              child: Text(
                _authMode == AuthMode.login ? 'Login' : 'Sing-up',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
