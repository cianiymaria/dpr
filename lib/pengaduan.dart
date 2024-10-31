class Pengaduan {
  final String tahun;
  final String provinsi;
  final String jumlahPengaduan;

  Pengaduan({
    required this.tahun,
    required this.provinsi,
    required this.jumlahPengaduan,
  });

  factory Pengaduan.fromJson(Map<String, dynamic> json) {
    // Check if `json['Tahun']` and `json['Provinsi']` are of type String
    final tahun =
        json['Tahun'] is String ? json['Tahun'] as String : 'Unknown Year';
    final provinsi = json['Provinsi'] is String
        ? json['Provinsi'] as String
        : 'Unknown Province';

    // `Jumlah_Pengaduan` is required, so it should not be null, but let's add a default value if necessary
    final jumlahPengaduan = json['Jumlah_Pengaduan'] ?? '0';

    return Pengaduan(
      tahun: tahun,
      provinsi: provinsi,
      jumlahPengaduan: jumlahPengaduan,
    );
  }
}
