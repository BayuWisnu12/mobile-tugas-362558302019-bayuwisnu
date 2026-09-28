import 'package:dio/dio.dart';
import 'package:poliwangi_mobile_starter/pengayaan/modul_04/models/announcement.dart';
import 'announcement_repository.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  AnnouncementRepositoryImpl({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://jsonplaceholder.typicode.com',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                headers: {'Accept': 'application/json'},
              ),
            );
            
  final Dio _dio;

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    try {
      final response = await _dio.get('/posts?_limit=10');
      final List<dynamic> data = response.data as List<dynamic>;

      // Memetakan JSON mentah dari server menjadi objek Announcement
      final List<Announcement> semua = List<Announcement>.generate(
        data.length,
        (int i) {
          final Map<String, dynamic> mentah = data[i] as Map<String, dynamic>;
          return Announcement.fromJson(<String, dynamic>{
            'id': mentah['id'],
            'title': mentah['title'],
            'content': mentah['body'], // Menggunakan 'body' dari JSON placeholder
            'author': 'Bagian Akademik Poliwangi',
            'category': ['Akademik', 'Beasiswa', 'Kegiatan', 'Prestasi'][i % 4],
            'date': '2026-09-${(i % 28 + 1).toString().padLeft(2, '0')}',
            'readCount': (i + 1) * 37,
          });
        },
        growable: false,
      );

      // Penyaringan kategori berdasarkan parameter yang dikirim
      if (category == null || category == 'Semua') {
        return semua;
      }
      
      return semua
          .where((item) => item.category.toLowerCase() == category.toLowerCase())
          .toList(growable: false);

    } on DioException catch (e) {
      String errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Koneksi ke server timeout. Periksa sambungan internet Anda.';
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'Gagal terhubung ke server. Periksa koneksi data atau Wi-Fi Anda.';
          break;
        case DioExceptionType.badResponse:
          errorMessage = 'Server merespons dengan kesalahan (${e.response?.statusCode}).';
          break;
        default:
          errorMessage = 'Terjadi kendala jaringan: ${e.message ?? 'Kesalahan tidak diketahui'}';
      }
      throw Exception(errorMessage);
    }
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    throw UnimplementedError();
  }
}