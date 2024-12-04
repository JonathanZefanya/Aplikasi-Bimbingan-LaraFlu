import 'package:bimbingan/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDosenScreen extends StatefulWidget {
  const HomeDosenScreen({Key? key}) : super(key: key);

  @override
  _HomeDosenScreenState createState() => _HomeDosenScreenState();
}

class _HomeDosenScreenState extends State<HomeDosenScreen> {
  int _selectedIndex = 0;
  String? username;
  final ApiService _apiService = ApiService();
  List<Widget> _widgetOptions = <Widget>[
    const BerandaPlaceholder(),
    const BerandaPlaceholder(),
    const BerandaPlaceholder(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      _widgetOptions = [
        BerandaView(username: username),
        JadwalView(username: username),
        RiwayatView(username: username),
      ];
    });
  }

  Future<void> _logout() async {
    final response = await _apiService.logout(username);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _pickDateTimeRange(BuildContext context) async {
    DateTimeRange? dateRange = await showDateRangePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2100));
    if (dateRange != null) {
      TimeOfDay? startTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 9, minute: 0),
      );

      if (startTime != null) {
        TimeOfDay? endTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 17, minute: 0),
        );

        if (endTime != null) {
          DateTime startDateTime = DateTime(
            dateRange.start.year,
            dateRange.start.month,
            dateRange.start.day,
            startTime.hour,
            startTime.minute,
          );
          DateTime endDateTime = DateTime(
            dateRange.end.year,
            dateRange.end.month,
            dateRange.end.day,
            endTime.hour,
            endTime.minute,
          );

          _sendDateRange(startDateTime.toString(), endDateTime.toString());
        }
      }
    }
  }

  Future<void> _sendDateRange(String start, String end) async {
    final response =
        await _apiService.addDateRangeBimbingan(username, start, end);

    if (response.data['success']) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Referensi Bimbingan berhasil ditambah!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));

      // Update Konten Jadwal
      setState(() {
        // (_widgetOptions[1] as JadwalView)._fetchJadwalBimbingan();

        _widgetOptions = [
          BerandaView(username: username),
          JadwalView(
            key: UniqueKey(),
            username: username,
          ),
          RiwayatView(username: username),
        ];
        // _selectedIndex = 0;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Terjadi kesalahan saat mengirim data!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Dosen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Jadwal Bimbingan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat Bimbingan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                _pickDateTimeRange(context);
              },
              child: const Icon(Icons.add),
              tooltip: 'Tambah Jadwal Bimbingan',
            )
          : null,
    );
  }
}

class BerandaView extends StatefulWidget {
  final String? username;

  BerandaView({Key? key, this.username}) : super(key: key);

  @override
  _BerandaViewState createState() => _BerandaViewState();
}

class _BerandaViewState extends State<BerandaView> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    _getStudents();
  }

  void _getStudents() async {
    final response = await _apiService.getStudentsList(widget.username);
    if (response.data['success']) {
      setState(() {
        students = List<Map<String, dynamic>>.from(response.data['data']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Halo ${widget.username ?? ''}!',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Selamat datang di aplikasi Aplikasi Penjadwalan Bimbingan Skripsi. Aplikasi ini dirancang untuk membantu Anda, sebagai dosen, dalam mengelola dan melacak proses bimbingan skripsi mahasiswa dengan lebih efisien dan terstruktur. Dengan aplikasi ini, Anda dapat dengan mudah mengatur jadwal bimbingan.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: students.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Daftar Mahasiswa Diampu",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              final student = students[index];
                              return ListTile(
                                title: Text(
                                    student['mahasiswa']['mahasiswa_nama']),
                                subtitle: Text(
                                    'Total Bimbingan: ${student['mahasiswa']['mahasiswa_total_bimbingan']}'),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      'Data sedang diambil atau Anda tidak memiliki mahasiswa'),
            ),
          ],
        ),
      ),
    );
  }
}

class JadwalView extends StatefulWidget {
  final String? username;

  JadwalView({Key? key, this.username}) : super(key: key);

  @override
  _JadwalViewState createState() => _JadwalViewState();
}

class _JadwalViewState extends State<JadwalView> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _jadwalFuture;

  @override
  void initState() {
    super.initState();
    _jadwalFuture = _fetchJadwalBimbingan();
  }

  Future<List<dynamic>> _fetchJadwalBimbingan() async {
    final response = await _apiService.getLecturerSchedule(widget.username);
    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to load riwayat bimbingan');
    }
  }

  Future<void> _pickDateTimeRange(BuildContext context, String id) async {
    DateTimeRange? dateRange = await showDateRangePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2100));
    if (dateRange != null) {
      TimeOfDay? startTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 9, minute: 0),
      );

      if (startTime != null) {
        TimeOfDay? endTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 17, minute: 0),
        );

        if (endTime != null) {
          DateTime startDateTime = DateTime(
            dateRange.start.year,
            dateRange.start.month,
            dateRange.start.day,
            startTime.hour,
            startTime.minute,
          );
          DateTime endDateTime = DateTime(
            dateRange.end.year,
            dateRange.end.month,
            dateRange.end.day,
            endTime.hour,
            endTime.minute,
          );

          _sendDateRange(id, startDateTime.toString(), endDateTime.toString());
        }
      }
    }
  }

  Future<void> _sendDateRange(String id, String start, String end) async {
    final response = await _apiService.updateDateRangeBimbingan(id, start, end);

    if (response.data['success']) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Referensi Bimbingan berhasil diperbarui!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));
      setState(() {
        _jadwalFuture = _fetchJadwalBimbingan();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Terjadi kesalahan saat mengirim data!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _deleteSchedule(String id) async {
    final response = await _apiService.deleteDateRangeBimbingan(id);

    if (response.data['success']) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Jadwal Bimbingan berhasil dihapus!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));
      setState(() {
        _jadwalFuture = _fetchJadwalBimbingan();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Terjadi kesalahan saat menghapus jadwal!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _jadwalFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data jadwal.'));
          }

          List<dynamic> jadwalBimbingan = snapshot.data!;

          return ListView.builder(
            itemCount: jadwalBimbingan.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> jadwal = jadwalBimbingan[index];
              DateTime startTime = DateTime.parse(jadwal['dosen_tanggal_dari']);
              DateTime endTime =
                  DateTime.parse(jadwal['dosen_tanggal_selesai']);
              String formattedStartTime =
                  DateFormat('dd MMM yyyy, HH:mm').format(startTime);
              String formattedEndTime =
                  DateFormat('dd MMM yyyy, HH:mm').format(endTime);

              // Dapatkan riwayat bimbingan
              List<dynamic> riwayatBimbingan = [];
              if (jadwal.containsKey('riwayat_bimbingan') &&
                  jadwal['riwayat_bimbingan'] is List) {
                riwayatBimbingan = jadwal['riwayat_bimbingan'];
              }

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('Jadwal Bimbingan'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Waktu Mulai: $formattedStartTime'),
                      Text('Waktu Selesai: $formattedEndTime'),
                      SizedBox(height: 8),
                      if (riwayatBimbingan.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Daftar Mahasiswa:', style: TextStyle(fontWeight: FontWeight.bold),),
                            Column(
                              children: riwayatBimbingan.map((riwayat) {
                                if (riwayat.containsKey('mahasiswa') &&
                                    riwayat['mahasiswa'] is Map) {
                                  var mahasiswa = riwayat['mahasiswa'];
                                  return ListTile(
                                    title: Text(mahasiswa['mahasiswa_nama']),
                                    subtitle: Text(
                                      'Total Bimbingan: ${mahasiswa['mahasiswa_total_bimbingan']}',
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              }).toList(),
                            ),
                          ],
                        ),
                      if (riwayatBimbingan.isEmpty)
                        Text(
                            'Belum ada mahasiswa yang terlibat dalam bimbingan ini.'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _pickDateTimeRange(
                              context, jadwal['jadwal_dosen_id'].toString());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Konfirmasi Hapus'),
                              content: Text(
                                  'Apakah Anda yakin ingin menghapus jadwal ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _deleteSchedule(jadwal['jadwal_dosen_id']);
                                  },
                                  child: Text('Hapus'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RiwayatView extends StatelessWidget {
  final ApiService _apiService = ApiService();
  final String? username;

  RiwayatView({Key? key, this.username}) : super(key: key);

  Future<List<dynamic>> _fetchRiwayatBimbingan() async {
    final response = await _apiService.getRiwayatBimbinganDosen(username);
    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to load riwayat bimbingan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchRiwayatBimbingan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada data riwayat bimbingan.'));
        } else {
          final List<dynamic> riwayat = snapshot.data!;
          return ListView.builder(
            itemCount: riwayat.length,
            itemBuilder: (context, index) {
              final item = riwayat[index];

              // Konversi tanggal dari string menjadi objek DateTime
              DateTime tanggalBimbingan = DateTime.parse(item['tanggal']);

              // Periksa apakah tanggal bimbingan sudah lewat dari hari ini
              bool isTanggalLewat = tanggalBimbingan.isBefore(DateTime.now());

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd MMMM yyyy').format(tanggalBimbingan),
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Bimbingan Dengan: ${item['mahasiswa']['mahasiswa_nama']}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Status: ${isTanggalLewat ? 'Sudah Selesai' : 'Belum Selesai'}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: isTanggalLewat ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class BerandaPlaceholder extends StatelessWidget {
  const BerandaPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
