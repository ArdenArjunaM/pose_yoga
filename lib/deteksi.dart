import 'package:flutter/material.dart';
import 'package:deteksi_yoga/flask_deteksi.dart'; // Sesuaikan dengan nama file dan path yang benar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PoseYogaDetectionScreen(),
    );
  }
}

class PoseYogaDetectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.pink,
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                        'assets/profile.jpg'), // Ganti dengan path gambar profil Anda
                  ),
                ],
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Pose Yoga Detection',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            // Informasi Deteksi (Contoh)
            Text(
              'Status: Sedang mendeteksi...',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            // Camera Icon (Contoh)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.camera_alt,
                size: 100,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            // Tombol Deteksi
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  // Navigasi ke halaman deteksi
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetectPage()),
                  );
                },
                child: Text(
                  'Mulai Deteksi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
