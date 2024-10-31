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

  @override
  Widget build(BuildContext context) {
    final filteredList = _selectedYear == null
        ? _pengaduanList
        : _pengaduanList.where((e) => e.tahun == _selectedYear).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Jumlah Pengaduan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for filtering by year
            DropdownButton<String>(
              hint: Text('Filter by Year',
                  style: TextStyle(color: Colors.deepPurple)),
              value: _selectedYear,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
              items: _pengaduanList
                  .map((pengaduan) => pengaduan.tahun)
                  .toSet()
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(
                          year ?? 'Unknown Year',
                          style: TextStyle(color: Colors.deepPurple),
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
                color: Colors.deepPurple,
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
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 4,
                          shadowColor: Colors.deepPurple.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
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
