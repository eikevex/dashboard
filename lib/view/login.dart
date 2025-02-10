  import 'dart:convert';

  import 'package:dashborad/widgets/background.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:get/route_manager.dart';
  import 'package:get/utils.dart';

  class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    bool _isHovered = false;
    bool _isForgotPassword = false;

    String _getFirebaseAuthErrorMessage(String code) {
      switch (code) {
        case 'invalid-email':
          return 'O email informado é inválido.';
        case 'user-not-found':
          return 'Usuário não encontrado.';
        case 'invalid-credential':
          return 'Senha incorreta.';
        case 'user-disabled':
          return 'Esta conta foi desativada.';
        case 'too-many-requests':
          return 'Muitas tentativas. Tente novamente mais tarde.';
        default:
          return 'Erro ao fazer login. Verifique suas credenciais.';
      }
    }

    Future<void> _signIn() async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = userCredential.user;
        if (user != null) {
          Get.offNamed('/home/');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao obter informações do usuário.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = _getFirebaseAuthErrorMessage(e.code);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    Future<void> _sendPasswordResetEmail() async {
      String email = _emailController.text;

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, insira um e-mail válido'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('E-mail de recuperação enviado.'),
            backgroundColor: Colors.green,
          ),
        );

        if (_isForgotPassword) {
          setState(() {
            _isForgotPassword = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        String message = 'Erro ao enviar e-mail de recuperação';
        if (e.code == 'invalid-email') {
          message = 'E-mail inválido';
        } else if (e.code == 'user-not-found') {
          message = 'Usuário não encontrado';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro inesperado: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Background(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 700,
                  height: 100,
                ),
                SizedBox(height: 20),
                Container(
                  width: 400,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF055383),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        if (!_isForgotPassword)
                          TextField(
                            obscureText: true,
                            controller: _passwordController,
                            onSubmitted: (value) {
                              if (_isForgotPassword) {
                                _sendPasswordResetEmail().then((_) {
                                  setState(() {
                                    _isForgotPassword = false;
                                  });
                                });
                              } else {
                                _signIn();
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_isForgotPassword) {
                              _sendPasswordResetEmail();
                            } else {
                              _signIn();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: Text(
                            _isForgotPassword ? 'Enviar' : 'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) {
                            setState(() {
                              _isHovered = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isHovered = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              _isForgotPassword = !_isForgotPassword;
                            },
                            child: Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                color: _isHovered ? Colors.blue : Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }
  }
