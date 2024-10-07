class Pengaduan {
    dynamic tahun;
    dynamic provinsi;
    String jumlahPengaduan;

    Pengaduan({
        required this.tahun,
        required this.provinsi,
        required this.jumlahPengaduan,
    });

    factory Pengaduan.fromJson(Map<String, dynamic> json) => Pengaduan(
        tahun: json["Tahun"],
        provinsi: json["Provinsi"],
        jumlahPengaduan: json["Jumlah_Pengaduan"],
    );

    Map<String, dynamic> toJson() => {
        "Tahun": tahun,
        "Provinsi": provinsi,
        "Jumlah_Pengaduan": jumlahPengaduan,
    };
}