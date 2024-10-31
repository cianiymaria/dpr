import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pengaduan.dart'; // Import the model

class PengaduanService {
  final String url = 'https://www.dpr.go.id/rest/?method=getJumlahPengaduan&tipe=json';

  Future<List<Pengaduan>> fetchPengaduan() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> pengaduanData = jsonData['pengaduan'];

      return pengaduanData.map((data) => Pengaduan.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
