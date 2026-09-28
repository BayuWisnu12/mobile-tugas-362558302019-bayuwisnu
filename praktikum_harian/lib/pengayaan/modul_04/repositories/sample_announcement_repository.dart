import 'package:poliwangi_mobile_starter/pengayaan/modul_04/models/announcement.dart';
import 'announcement_repository.dart';

class SampleAnnouncementRepository implements AnnouncementRepository {
  /// Perhatikan `List<Announcement>.of(...)`.
  /// `Announcement.getSampleAnnouncements()` mengembalikan list `const`, dan
  /// list `const` TIDAK DAPAT DIUBAH. Tanpa penyalinan ini, `_items.add()`
  /// akan melempar `UnsupportedError` saat dijalankan — padahal 
  /// `flutter analyze` tetap hijau.
  final List<Announcement> _items = List<Announcement>.of(Announcement.getSampleAnnouncements());

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    // Simulasi jeda jaringan selama 1 detik
    await Future<void>.delayed(const Duration(seconds: 1));
    
    if (category == null || category == 'Semua') {
      return _items;
    }
    
    return _items
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList(growable: false);
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    _items.add(announcement);
    return announcement;
  }
}