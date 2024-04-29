// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { signUp, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

// final deviceSize = MediaQuery.of(context).size;
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  bool _isSignIn() => _authMode == AuthMode.login;
  // bool _isSignUp() => _authMode == AuthMode.signUp;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));
    _slideAnimation = Tween(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));

    // _heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  void _switchAuthMode() {
    setState(() {
      if (_isSignIn()) {
        _authMode = AuthMode.signUp;
        _animationController?.forward();
      } else {
        _authMode = AuthMode.login;
        _animationController?.reverse();
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
      if (_isSignIn()) {
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await auth.signUp(
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),

        height:
            _isSignIn() ? deviceSize.height * 0.35 : deviceSize.height * 0.5,
        // height:_isSignIn() ? deviceSize.height * 0.35 : deviceSize.height * 0.45,
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
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isSignIn() ? 0 : 60,
                  maxHeight: _isSignIn() ? 0 : 120,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Confirm password'),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      validator: _isSignIn()
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
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                ElevatedButton(
                    onPressed: () {}, child: const CircularProgressIndicator())
              else
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
                    _authMode == AuthMode.login ? 'Sign-In' : 'Sign-up',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _isSignIn() ? 'Sign up' : 'Sign in',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 8)
            ],
          ),
        ),
      ),
    );
  }
}
