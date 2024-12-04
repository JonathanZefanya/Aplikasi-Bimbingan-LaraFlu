import 'package:bimbingan/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMahasiswaScreen extends StatefulWidget with ContentMixin {
  const HomeMahasiswaScreen({Key? key}) : super(key: key);

  @override
  _HomeMahasiswaScreenState createState() => _HomeMahasiswaScreenState();
}

class _HomeMahasiswaScreenState extends State<HomeMahasiswaScreen> {
  int _selectedIndex = 0;
  String? username;
  final ApiService _apiService = ApiService();
  List<Widget> _widgetOptions = <Widget>[
    const BerandaPlaceholder(),
    const BerandaPlaceholder(),
  ];
  List<Widget> _widgetBeranda = <Widget>[];

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      _getContentHome();
    });
  }

  void _getContentHome() async {
    final response = await _apiService.getMahasiswasDashboard(username);

    String? startBimbingan =
        response.data['data']['mahasiswa']['mahasiswa_start_bimbingan'];
    String? endBimbingan =
        response.data['data']['mahasiswa']['mahasiswa_end_bimbingan'];
    int? statusBimbingan =
        response.data['data']['mahasiswa']['mahasiswa_status_bimbingan'];

    if (startBimbingan == null || endBimbingan == null) {
      _widgetBeranda = [
        const Text(
          "Kamu belum memilih tanggal ketersediaan bimbingan",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        )
      ];
    } else {
      String formattedStartDate =
          DateFormat('dd MMMM yyyy').format(DateTime.parse(startBimbingan));
      String formattedEndDate =
          DateFormat('dd MMMM yyyy').format(DateTime.parse(endBimbingan));
      _widgetBeranda = [
        Center(
          child: Text(
            "Kamu sudah menentukan tanggal ketersediaan bimbingan dari \n $formattedStartDate - $formattedEndDate",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        )
      ];
    }

    setState(() {
      _widgetOptions = [
        BerandaView(
            username: username,
            content: _widgetBeranda,
            isBimbingan: statusBimbingan),
        RiwayatView(
          username: username,
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Mahasiswa'),
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
            label: 'Riwayat Bimbingan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class BerandaView extends StatefulWidget {
  final String? username;
  int? isBimbingan;
  final List<Widget>? content;

  BerandaView({Key? key, this.username, this.content, this.isBimbingan})
      : super(key: key);

  @override
  _BerandaViewState createState() => _BerandaViewState();
}

class _BerandaViewState extends State<BerandaView> with ContentMixin {
  final ApiService _apiService = ApiService();

  void _showDateRangePicker() async {
    final initialDate = DateTime.now();
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: DateTimeRange(
          start: initialDate, end: initialDate.add(const Duration(days: 7))),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.light(primary: Colors.blue),
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            colorScheme: ColorScheme.light(primary: Colors.blue),
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      _sendDateRange(picked.start.toString(), picked.end.toString());
    }
  }

  Future<void> _toggleStatusBimbingan(bool turnOn) async {
    final response = turnOn
        ? await _apiService.onStatusBimbingan(widget.username)
        : await _apiService.offStatusBimbingan(widget.username);

    if (response.data['success']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Status Bimbingan berhasil ${turnOn ? 'diaktifkan' : 'dimatikan'}!'),
        duration: const Duration(seconds: 2),
        backgroundColor: turnOn ? Colors.green : Colors.red,
      ));

      setState(() {
        widget.isBimbingan = turnOn ? 1 : 0;
      });

      getContentHome(widget.username, _apiService, (newContent) {
        setState(() {
          widget.content!.clear();
          widget.content!.addAll(newContent);
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Terjadi kesalahan saat mengirim data!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _sendDateRange(String start, String end) async {
    final response =
        await _apiService.sendDateRange(widget.username, start, end);

    if (response.data['success']) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Referensi Bimbingan berhasil diperbarui!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));

      getContentHome(widget.username, _apiService, (newContent) {
        setState(() {
          widget.content!.clear();
          widget.content!.addAll(newContent);
        });
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
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Halo kak ${widget.username ?? ''}!',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Selamat datang di aplikasi Aplikasi Penjadwalan Bimbingan Skripsi. Aplikasi ini dirancang untuk membantu kamu dalam mengatur dan melacak proses bimbingan skripsi dengan lebih efisien dan terstruktur.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            if (widget.content != null) ...widget.content!,
            const SizedBox(height: 16.0),
            if (widget.isBimbingan != null && widget.isBimbingan! == 1)
              Column(
                children: [
                  _buildButton('Matikan Status Bimbingan', Colors.red,
                      () => _toggleStatusBimbingan(false)),
                  _buildButton('Ubah Referensi Jadwal Bimbingan', Colors.blue,
                      _showDateRangePicker),
                ],
              )
            else
              _buildButton('Nyalakan Status Bimbingan', Colors.green,
                  () => _toggleStatusBimbingan(true)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }
}

class RiwayatView extends StatelessWidget {
  final ApiService _apiService = ApiService();
  final String? username;

  RiwayatView({Key? key, this.username}) : super(key: key);

  Future<List<dynamic>> _fetchRiwayatBimbingan() async {
    final response = await _apiService.getRiwayatBimbingan(username);
    print(response.toString());
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
                        DateFormat('dd MMMM yyyy')
                            .format(DateTime.parse(item['tanggal'])),
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Bimbingan Dengan: ${item['dosen']['dosen_nama']}',
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

mixin ContentMixin {
  Future<void> getContentHome(String? username, ApiService apiService,
      Function(List<Widget>) updateContent) async {
    final response = await apiService.getMahasiswasDashboard(username);

    String? startBimbingan =
        response.data['data']['mahasiswa']['mahasiswa_start_bimbingan'];
    String? endBimbingan =
        response.data['data']['mahasiswa']['mahasiswa_end_bimbingan'];

    String formattedStartDate = '';
    if (startBimbingan != null) {
      formattedStartDate =
          DateFormat('dd MMMM yyyy').format(DateTime.parse(startBimbingan));
    }

    String formattedEndDate = '';
    if (endBimbingan != null) {
      formattedEndDate =
          DateFormat('dd MMMM yyyy').format(DateTime.parse(endBimbingan));
    }

    List<Widget> widgetBeranda;

    if (startBimbingan == null || endBimbingan == null) {
      widgetBeranda = [
        const Text(
          "Kamu belum memilih tanggal ketersediaan bimbingan",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        )
      ];
    } else {
      widgetBeranda = [
        Center(
          child: Text(
            "Kamu sudah menentukan tanggal ketersediaan bimbingan dari \n $formattedStartDate - $formattedEndDate",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        )
      ];
    }

    updateContent(widgetBeranda);
  }
}
