import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pengaduan.dart';

class PengaduanService {
  final String url = 'https://www.dpr.go.id/rest/?method=getJumlahPengaduan&tipe=json';

  Future<List<Pengaduan>> fetchPengaduan() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
        // Logging JSON response untuk debugging
        print('Response JSON: $jsonData');

        // Periksa apakah JSON mengandung key 'pengaduan' dan pastikan itu adalah list
        if (jsonData != null && jsonData['pengaduan'] != null && jsonData['pengaduan'] is List) {
          final List<dynamic> pengaduanData = jsonData['pengaduan'];
          return pengaduanData.map((data) => Pengaduan.fromJson(data)).toList();
        } else {
          print('Data "pengaduan" tidak ditemukan atau bukan list');
          return []; // Kembalikan list kosong jika data tidak tersedia
        }
      } else {
        print('Gagal memuat data. Status code: ${response.statusCode}');
        return []; // Kembalikan list kosong jika gagal
      }
    } catch (e) {
      print('Terjadi kesalahan: $e'); // Log kesalahan untuk debugging
      return []; // Kembalikan list kosong jika terjadi kesalahan
    }
  }
}
