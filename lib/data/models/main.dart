import 'package:flutter/material.dart';
import 'package:tugas_pemberitahuan/data/models/pengaduan.dart';
import 'package:tugas_pemberitahuan/services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengaduan DPR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PengaduanScreen(),
    );
  }
}

class PengaduanScreen extends StatefulWidget {
  @override
  _PengaduanScreenState createState() => _PengaduanScreenState();
}

class _PengaduanScreenState extends State<PengaduanScreen> {
  final ApiService apiService = ApiService();
  Future<List<Pengaduan>>? futurePengaduan;

  @override
  void initState() {
    super.initState();
    futurePengaduan = apiService.getPengaduan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pengaduan DPR'),
      ),
      body: FutureBuilder<List<Pengaduan>>(
        future: futurePengaduan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data pengaduan'));
          } else {
            List<Pengaduan> pengaduanList = snapshot.data!;
            return ListView.builder(
              itemCount: pengaduanList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pengaduanList[index].jumlahPengaduan), // Pastikan atribut ini ada
                  subtitle: Text(pengaduanList[index].tahun), // Pastikan atribut ini ada
                );
              },
            );
          }
        },
      ),
    );
  }
}
