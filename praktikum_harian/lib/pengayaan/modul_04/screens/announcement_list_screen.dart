import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poliwangi_mobile_starter/pengayaan/modul_04/widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';
import '../providers/announcement_provider.dart';
import '../models/announcement.dart';

class AnnouncementListScreen extends ConsumerWidget {
  const AnnouncementListScreen({super.key});

  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memantau state data pengumuman dan kategori aktif melalui Riverpod
    final asyncAnnouncements = ref.watch(announcementsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman (Fase B - Riverpod)'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: () => ref.invalidate(announcementsProvider),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Baris Filter Kategori
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _kategori.map((String kategori) {
                final bool dipilih = kategori == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(kategori),
                    selected: dipilih,
                    onSelected: (_) {
                      ref.read(selectedCategoryProvider.notifier).select(kategori);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          // Body menggunakan AsyncValue.when() bawaan Riverpod
          Expanded(
            child: asyncAnnouncements.when(
              // 1. Keadaan Memuat (Loading)
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Memuat pengumuman dari server...'),
                  ],
                ),
              ),
              // 2. Keadaan Gagal (Error)
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        err.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => ref.invalidate(announcementsProvider),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              ),
              // 3 & 4. Keadaan Berhasil / Kosong (Data)
              data: (items) {
                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada pengumuman untuk kategori "$selectedCategory".',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(announcementsProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final announcement = items[index];
                      return AnnouncementCard(
                        announcement: announcement,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => AnnouncementDetailScreen(announcement: announcement),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}