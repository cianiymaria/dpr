import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_pemberitahuan/data/models/pengaduan.dart';

class ApiService {
  final String apiUrl =
      'https://dpr.go.id/rest/?method=getJumlahPengaduan&tipe=json'; // Ganti dengan URL API Anda
  final String apiUrlDetail =
      'www.dpr.go.id/rest/?method=getDataAnggota&id='; // Ganti dengan URL API Anda

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept-Language': 'en-US,en;q=0.5'
    };
  }

  // Fungsi untuk mendapatkan semua pengaduan dari API
  Future<List<Pengaduan>> getPengaduan() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: _buildHeaders(),
      );

      // Mengecek apakah response sukses (kode status 200)
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        List<dynamic> hasil = body['pengaduan'];
        // Mengonversi setiap item dari JSON ke objek Member

        List<Pengaduan> pengaduan =
            hasil.map((dynamic item) => Pengaduan.fromJson(item)).toList();

        return pengaduan;
      } else {
        throw Exception('Failed to load members');
      }
    } catch (e) {
      throw Exception('Error fetching members: $e');
    }
  }

  // Fungsi untuk mendapatkan satu member berdasarkan ID dari API
  // Future<MemberDetail> getMemberById(String id) async {
  //   final response = await http.get(
  //     Uri.parse('$apiUrlDetail$id&tipe=json'),
  //     headers: _buildHeaders(),
  //   );

  //   if (response.statusCode == 200) {
  //     return MemberDetail.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load member');
  //   }
  // }

}