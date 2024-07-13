import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'verification_page.dart';
import 'login_page.dart';
import 'home_page.dart'; // Import halaman Home
import 'deteksi.dart'; // Import halaman Deteksi
import 'profile_page.dart'; // Import halaman Profile
import 'forgot_password_page.dart'; // Import halaman Forgot Password

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/verification': (context) => VerificationScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(), // Tambahkan rute untuk halaman Home
        '/deteksi': (context) =>
            PoseYogaDetectionScreen(), // Tambahkan rute untuk halaman Deteksi
        '/profile': (context) =>
            ProfilePage(), // Tambahkan rute untuk halaman Profile
        '/forgot_password': (context) =>
            ForgotPasswordScreen(), // Tambahkan rute untuk halaman Forgot Password
      },
    );
  }
}
