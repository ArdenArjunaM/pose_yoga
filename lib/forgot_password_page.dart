import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    final url = Uri.parse(
        'http://10.0.2.2:5000/api/reset_password'); // Ganti dengan URL API reset password Anda
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset Password'),
            content: Text(responseJson['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  _showChangePasswordDialog(
                      context); // Tampilkan dialog untuk mengubah password baru
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle error response
      final responseJson = jsonDecode(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset Password Failed'),
            content: Text(responseJson['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _showChangePasswordDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'New Password'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => changePassword(context),
                child: Text('Change Password'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> changePassword(BuildContext context) async {
    final url = Uri.parse(
        'http://10.0.2.2:5000/api/update_password'); // Ganti dengan URL API update password Anda
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'new_password': newPasswordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Password'),
            content: Text(responseJson['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle error response
      final responseJson = jsonDecode(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Password Failed'),
            content: Text(responseJson['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => resetPassword(context),
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
