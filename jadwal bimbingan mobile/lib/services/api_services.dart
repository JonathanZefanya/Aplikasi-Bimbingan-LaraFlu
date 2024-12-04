import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://bimbingan.jojo.tirtagt.xyz/api',
  ));

  // AUTH
  Future<Response> login(String username, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("TOKENN");
      print(prefs.getString('tokenMobile'));
      final response = await _dio.post('/login', data: {
        'username': username,
        'password': password,
        'token': prefs.getString('tokenMobile'),
      });
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> logout(String? username) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/logout', data: {
        'username': username,
      });
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  // MAHASISWA

  Future<Response> getMahasiswasDashboard(String? id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/mahasiswa-dashboard', data: {
        'id': id,
      });
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> sendDateRange(
      String? username, String? start, String? end) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/update-date-mahasiswa',
          data: {'username': username, 'start': start, 'end': end});
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> offStatusBimbingan(String? username) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/off-status-bimbingan', data: {
        'username': username,
      });
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> onStatusBimbingan(String? username) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/on-status-bimbingan', data: {
        'username': username,
      });
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> getRiwayatBimbingan(String? username) async {
    try {
      final response = await _dio.post('/riwayat-bimbingan', data: {
        'username': username,
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DOSEN

  Future<Response> getDosenDashboard(String? id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/dosen-dashboard', data: {
        'id': id,
      });
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> getStudentsList(String? username) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/dosen-daftar-mahasiswa', data: {
        'username': username,
      });
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> getRiwayatBimbinganDosen(String? username) async {
    try {
      final response = await _dio.post('/riwayat-bimbingan-dosen', data: {
        'username': username,
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getLecturerSchedule(String? username) async {
    try {
      final response = await _dio.post('/daftar-bimbingan-dosen', data: {
        'username': username,
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addDateRangeBimbingan(
      String? username, String? start, String? end) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/add-date-dosen',
          data: {'username': username, 'start': start, 'end': end});
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> updateDateRangeBimbingan(
      String? id, String? start, String? end) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/edit-date-dosen',
          data: {'id': id, 'start': start, 'end': end});
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  Future<Response> deleteDateRangeBimbingan(
      String? id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _dio.post('/delete-date-dosen',
          data: {'id': id});
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return e.response!;
      } else {
        // Request failed due to network or other issues
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  
}
