import 'package:poliwangi_mobile_starter/pengayaan/modul_04/models/announcement.dart';

// Interface Repository: Kontrak abstraksi data layer yang independen dari sumber data
abstract class AnnouncementRepository {
  Future<List<Announcement>> getAnnouncements({String? category});
  Future<Announcement> addAnnouncement(Announcement announcement);
}
