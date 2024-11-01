import 'package:flutter/material.dart';
import 'pengaduan_service.dart'; // Import the service
import 'pengaduan.dart'; // Import the model

class PengaduanList extends StatefulWidget {
  @override
  _PengaduanListState createState() => _PengaduanListState();
}

class _PengaduanListState extends State<PengaduanList> {
  final PengaduanService pengaduanService = PengaduanService();
  List<Pengaduan> _pengaduanList = [];
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    _fetchPengaduan();
  }

  void _fetchPengaduan() async {
    try {
      final data = await pengaduanService.fetchPengaduan();
      setState(() {
        _pengaduanList = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _navigateToDetail(Pengaduan pengaduan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PengaduanDetail(pengaduan: pengaduan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _selectedYear == null
        ? _pengaduanList
        : _pengaduanList.where((e) => e.tahun == _selectedYear).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('JUMLAH PENGADUAN PROVINSI', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for filtering by year
            DropdownButton<String>(
              hint: Text('Menyaring Berdasarkan Tahun', style: TextStyle(color: Colors.black)),
              value: _selectedYear,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              items: _pengaduanList
                  .map((pengaduan) => pengaduan.tahun)
                  .toSet()
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(
                          year ?? 'Tahun Tidak Diketahui',
                          style: TextStyle(color: Colors.black),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedYear = value;
                });
              },
              underline: Container(
                height: 1,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final pengaduan = filteredList[index];
                        return GestureDetector(
                          onTap: () => _navigateToDetail(pengaduan),
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            elevation: 4,
                            shadowColor: Colors.black.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              leading: CircleAvatar(
                                backgroundColor: Colors.yellow[600],
                                child: Icon(Icons.report, color: Colors.white),
                              ),
                              title: Text(
                                'Tahun: ${pengaduan.tahun ?? "Unknown"}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Text(
                                'Jumlah Pengaduan: ${pengaduan.jumlahPengaduan}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// New widget to display detail of the selected pengaduan
class PengaduanDetail extends StatelessWidget {
  final Pengaduan pengaduan;

  const PengaduanDetail({Key? key, required this.pengaduan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengaduan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tahun: ${pengaduan.tahun ?? "Unknown"}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Jumlah Pengaduan: ${pengaduan.jumlahPengaduan}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more details as necessary
          ],
        ),
      ),
    );
  }
}
