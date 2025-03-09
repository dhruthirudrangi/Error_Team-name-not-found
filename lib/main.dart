import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'auth_pages.dart';
import 'picture_screen.dart';
import 'sos_screen.dart';
import 'news_screen.dart';
import 'chat_screen.dart'; // ✅ Import ChatScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DishguiseApp());
}

class DishguiseApp extends StatelessWidget {
  const DishguiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dishguise & SOS',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const PictureScreen(); // ✅ Show PictureScreen after login
          } else {
            return const AuthPage();
          }
        },
      ),
      routes: {
        '/sos': (context) => const SOSScreen(),
        '/news': (context) => const NewsScreen(),
        '/chat': (context) => ChatScreen(), // ✅ Add ChatScreen route
      },
    );
  }
}
