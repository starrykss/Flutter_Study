import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:section_09/screens/chat.dart';
import 'package:section_09/screens/auth.dart';
import 'package:section_09/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          // 로딩중 화면
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          // 채팅 화면
          // - 인증 성공 시, 데이터 반환
          if (snapshot.hasData) {
            return const ChatScreen();
          }

          // 인증 화면
          return const AuthScreen();
        },
      ),
    );
  }
}
