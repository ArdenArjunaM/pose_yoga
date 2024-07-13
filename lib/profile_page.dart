import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ProfilePage(),
      routes: {
        '/login': (context) => LoginPage(),
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  void _logout(BuildContext context) async {
    String apiUrl = 'http://194.31.53.102:21128/api/logout';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil Logout')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal terhubung ke server')),
      );
    }
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                    context, '/login'); // Pindah ke halaman verifikasi
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _confirmLogout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.pink, width: 4),
                  image: DecorationImage(
                    image: AssetImage('assets/images/default_profile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pink),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditDataPage(mode: EditMode.EditProfile),
                    ),
                  );
                },
                child: Text('Ubah Profil'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pink),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditDataPage(mode: EditMode.EditEmail),
                    ),
                  );
                },
                child: Text('Ubah Email Profil'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pink),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditDataPage(mode: EditMode.EditPassword),
                    ),
                  );
                },
                child: Text('Ubah Sandi Profil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum EditMode {
  EditProfile,
  EditEmail,
  EditPassword,
}

class EditDataPage extends StatelessWidget {
  final EditMode mode;
  final TextEditingController oldEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  EditDataPage({required this.mode});

  Future<void> updateData(BuildContext context) async {
    String apiUrl = '';
    Map<String, String> data = {};

    if (mode == EditMode.EditProfile) {
      data = {
        'username': usernameController.text,
      };
      apiUrl = 'http://194.31.53.102:21128/edit_profile';
    } else if (mode == EditMode.EditEmail) {
      if (newEmailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email tidak boleh kosong')),
        );
        return;
      }
      apiUrl = 'http://194.31.53.102:21128/change_email';
      data = {
        'new_email': newEmailController.text,
      };
    } else if (mode == EditMode.EditPassword) {
      if (oldPasswordController.text.isEmpty ||
          newPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sandi tidak boleh kosong')),
        );
        return;
      }
      apiUrl = 'http://194.31.53.102:21128/update_password';
      data = {
        'Password lama': oldPasswordController.text,
        'Password baru': newPasswordController.text,
      };
    }

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil diperbarui')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal terhubung ke server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    String labelText = '';

    if (mode == EditMode.EditProfile) {
      title = 'Ubah Profil';
      labelText = 'Nama Baru';
    } else if (mode == EditMode.EditEmail) {
      title = 'Ubah Email Profil';
      labelText = 'Email Baru';
    } else if (mode == EditMode.EditPassword) {
      title = 'Ubah Sandi Profil';
      labelText = 'Sandi Baru';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (mode == EditMode.EditEmail)
              TextField(
                controller: newEmailController,
                decoration: InputDecoration(
                  labelText: labelText,
                ),
              ),
            if (mode == EditMode.EditPassword)
              Column(
                children: [
                  TextField(
                    controller: oldPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Sandi Lama',
                    ),
                    obscureText: true,
                  ),
                  TextField(
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Sandi Baru',
                    ),
                    obscureText: true,
                  ),
                ],
              ),
            if (mode == EditMode.EditProfile)
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: labelText,
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
              onPressed: () {
                updateData(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}
