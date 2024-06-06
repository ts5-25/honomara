import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:honomara/pages/record_page.dart';
import 'package:honomara/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ホノマラ フルマラソンの記録',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'NotoSerifJP',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 245, 168, 216),
        ),
        textTheme: GoogleFonts.notoSansJpTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              ),
        ),
      ),
      home: LoginPage(),
      routes: {
        '/recordPage': (context) => const RecordPage(), // RecordPageを'/recordPage'ルートにマッピング
      },
    );
  }
}