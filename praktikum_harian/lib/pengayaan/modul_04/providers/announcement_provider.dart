import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poliwangi_mobile_starter/pengayaan/modul_04/models/announcement.dart';
import '../repositories/announcement_repository.dart';
import '../repositories/announcement_repository_impl.dart';
import '../repositories/sample_announcement_repository.dart';

// Provider untuk mendeteksi apakah menggunakan data sampel atau jaringan nyata
final useSampleDataProvider = Provider<bool>((ref) {
  return const bool.fromEnvironment('USE_SAMPLE_DATA');
});

// Provider untuk memilih implementasi repository yang digunakan
final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  if (ref.watch(useSampleDataProvider)) {
    return SampleAnnouncementRepository();
  }
  return AnnouncementRepositoryImpl();
});

// Notifier untuk mengelola state kategori yang sedang dipilih
class SelectedCategory extends Notifier<String> {
  @override
  String build() => 'Semua';
  void select(String value) => state = value;
}

final selectedCategoryProvider = NotifierProvider<SelectedCategory, String>(SelectedCategory.new);

// FutureProvider yang otomatis dihitung ulang saat kategori atau repository berubah
final announcementsProvider = FutureProvider<List<Announcement>>((ref) async {
  final repository = ref.watch(announcementRepositoryProvider);
  final category = ref.watch(selectedCategoryProvider);
  return repository.getAnnouncements(category: category);
});
