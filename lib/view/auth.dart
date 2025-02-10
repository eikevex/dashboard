  import 'package:dashborad/view/home.dart';
  import 'package:dashborad/view/login.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:get/route_manager.dart';

  class AuthWrapper extends StatelessWidget {
    const AuthWrapper({super.key});

    @override
    Widget build(BuildContext context) {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          }

          if (snapshot.hasError) {
            return Center(
                child:
                    Text('Erro ao carregar autenticação: ${snapshot.error}'));
          }

          User? user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else {
            return HomePage();
          }
        },
      );
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginPage());
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao fazer logout: $e');
    }
  }

  class LoadingIndicator extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Center(child: CircularProgressIndicator());
    }
  }
