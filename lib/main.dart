import 'package:dashborad/controllers/filterControllers.dart';
import 'package:dashborad/controllers/reviewsController.dart';
import 'package:dashborad/firebase_options.dart';
import 'package:dashborad/pages/auth.dart';
import 'package:dashborad/pages/home.dart';
import 'package:dashborad/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }
  await GetStorage.init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => FilterManager()),
      ChangeNotifierProvider(create: (_) => ReviewsController()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: AuthWrapper(),
      getPages: [
        GetPage(name: '/home/:id', page: () => HomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
      ],
    );
  }
}
