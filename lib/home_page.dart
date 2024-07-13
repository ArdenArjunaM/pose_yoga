import 'package:flutter/material.dart';
import 'profile_page.dart'; // Pastikan file sudah diimpor dengan benar
import 'deteksi.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigasi ke halaman profil
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.pink,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman Deteksi
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PoseYogaDetectionScreen()),
                          );
                        },
                        child: Text(
                          'Deteksi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        'https://wallpaperaccess.com/full/1642718.jpg',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Jenis - jenis pose yoga',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: yogaPoses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YogaDetailPage(yogaPoses[index]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Hero(
                          tag: 'yogaImage$index',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              yogaPoses[index]['imageUrl'] ??
                                  'https://via.placeholder.com/100',
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            yogaPoses[index]['name'] ?? 'Pose Tidak Diketahui',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            yogaPoses[index]['description'] ??
                                'Deskripsi tidak tersedia',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (yogaPoses[index]['description'] == null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                // Implementasi fungsi untuk membaca selengkapnya
                              },
                              child: Text(
                                'Baca Selengkapnya',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class YogaDetailPage extends StatelessWidget {
  final Map<String, String> yogaPose;

  YogaDetailPage(this.yogaPose);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(yogaPose['name'] ?? 'Detail Pose Yoga'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'yogaImage${yogaPoses.indexOf(yogaPose)}',
              child: Image.network(
                yogaPose['imageUrl'] ?? 'https://via.placeholder.com/300x150',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              yogaPose['name'] ?? 'Nama Pose',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              yogaPose['description'] ?? 'Deskripsi tidak tersedia',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> yogaPoses = [
  {
    'name': 'Adho Mukha Svanasana',
    'imageUrl':
        'https://th.bing.com/th/id/OIP.CCkUgNiDhIBsegr8HJwZTgHaE8?rs=1&pid=ImgDetMain',
    'description':
        'Adho mukha svanasana adalah gerakan yang perlu kamu ketahui sebagai pemula karena gerakan ini ada di semua jenis yoga. Gerakan ini meminta kamu untuk melengkungkan tubuh layaknya huruf V terbalik. Adho mukha svanasana membuat sistem saraf kamu lebih rileks dan membantu mencapai tubuh yang fleksibel. Selain itu gerakan ini juga melatih kekuatan otot lengan kamu.',
  },
  {
    'name': 'Baddha Konasana',
    'imageUrl':
        'https://th.bing.com/th/id/OIP.yJMi0liFbBE5FHali-wXvAHaGC?rs=1&pid=ImgDetMain',
    'description':
        'Baddha Konasana atau Bound Angle Pose adalah pembuka pinggul duduk tingkat pemula. Pose ini biasanya dilakukan untuk pemanasan area panggul, asana pembukaan pinggul yang dalam, atau untuk meditasi. Pose ini juga dikenal sebagai Pose Kupu-kupu karena Anda melebarkan kaki seperti sayap kupu-kupu, dan tindakan ini membantu Anda membuka jaringan panggul bagian dalam dan menargetkan otot selangkangan untuk mendapatkan kelenturan. Melipat ke depan selama pose ini juga dapat membantu meringankan nyeri punggung bagian bawah. Selain itu, ini adalah pose yang bagus untuk dilakukan selama kehamilan untuk melahirkan secara alami.',
  },
  {
    'name': 'Camatkarasana',
    'imageUrl':
        'https://th.bing.com/th/id/OIP.tvp70n2D--iLHjNmWtygLgHaE8?rs=1&pid=ImgDetMain',
    'description':
        'Pose liar yang meningkatkan kekuatan tubuh bagian atas dan fleksibilitas.',
  },
  {
    'name': 'Dandasana',
    'imageUrl':
        'https://global-uploads.webflow.com/5fe33d036237252135e3e74d/623c182a1bf8315b1d0adb7f_Dandasana%20by%20cult.fit.jpg',
    'description':
        'Pose staf yang merupakan pose dasar untuk latihan pernapasan dan postur tubuh yang baik.',
  },
  {
    'name': 'Eka Pada Koundinyanasana I',
    'imageUrl':
        'https://www.fitsri.com/wp-content/uploads/2021/03/Eka-Pada-Koundinyasana-I.jpeg',
    'description':
        'Pose keseimbangan lengan yang menantang dan membutuhkan kekuatan inti yang besar.',
  },
  {
    'name': 'Halasana',
    'imageUrl': 'https://via.placeholder.com/100',
    'description':
        'Pose bajak yang membantu meregangkan tulang belakang dan mengurangi stres.',
  },
  {
    'name': 'Janusirsasana',
    'imageUrl': 'https://via.placeholder.com/100',
    'description':
        'Pose kepala ke lutut yang meningkatkan fleksibilitas dan meredakan ketegangan.',
  },
  {
    'name': 'Kapotasana',
    'imageUrl': 'https://via.placeholder.com/100',
    'description':
        'Pose merpati yang membuka pinggul dan meningkatkan fleksibilitas punggung.',
  },
  {
    'name': 'Marichyasana',
    'imageUrl': 'https://via.placeholder.com/100',
    'description':
        'Pose Marichi yang membantu meregangkan tulang belakang dan bahu.',
  },
  {
    'name': 'Natarajasana',
    'imageUrl': 'https://via.placeholder.com/100',
    'description':
        'Pose penari yang menantang keseimbangan dan kekuatan tubuh.',
  },
  {
    'name': 'Padmasana',
    'imageUrl': 'https://via.placeholder.com/100',
    'description':
        'Pose lotus yang sering digunakan dalam meditasi untuk menenangkan pikiran.',
  },
  {
    'name': 'Savasana',
    'imageUrl': 'https://via.placeholder.com/100',
    'description':
        'Pose mayat yang digunakan untuk relaksasi total di akhir sesi yoga.',
  },
];
