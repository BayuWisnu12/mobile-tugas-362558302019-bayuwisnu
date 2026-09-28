import 'package:flutter/material.dart';
import 'package:poliwangi_mobile_starter/modul_04/models/announcement.dart';
import 'package:poliwangi_mobile_starter/modul_04/screens/announcement_detail_screen.dart';
import 'package:poliwangi_mobile_starter/modul_04/services/announcement_api.dart';
import 'package:poliwangi_mobile_starter/modul_04/widgets/announcement_card.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key, this.api});

  /// Dapat disuntikkan dari luar (widget test atau demo offline).
  final AnnouncementApi? api;

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  late final AnnouncementApi _api = widget.api ?? AnnouncementApi();

  late Future<List<Announcement>> _futurePengumuman;

  String _kategoriTerpilih = 'Semua';
  int _percobaan = 1;
  String _pencarian = '';

  @override
  void initState() {
    super.initState();
    _futurePengumuman = _api.ambilPengumuman();
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  Future<void> _muatUlang() async {
    final Future<List<Announcement>> futureBaru = _api.ambilPengumuman();
    setState(() {
      _futurePengumuman = futureBaru;
      _percobaan++;
    });

    try {
      await futureBaru;
    } catch (_) {
      // Error ditangani FutureBuilder lewat sanpshot.hasError
    }
  }

  void _pilihKategori(String kategori) {
    if (kategori == _kategoriTerpilih) return;
    setState(() => _kategoriTerpilih = kategori);
  }

  void _bukaDetail(Announcement announcement) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AnnouncementDetailScreen(announcement: announcement),
      ),
    );
  }

  Widget _buildMemuat() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildGagal(Object error) {
    return Center(child: Text('Gagal: $error'));
  }

  Widget _buildKosong() {
    return const Center(child: Text('Tidak ada pengumuman.'));
  }

  Widget _buildDaftar(List<Announcement> tampil) {
    return ListView.builder(
      itemCount: tampil.length,
      itemBuilder: (context, index) {
        return AnnouncementCard(
          announcement: tampil[index],
          onTap: () => _bukaDetail(tampil[index]),
        );
      },
    );
  }

  Widget _buildBarisFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: _kategori.map((String kategori) {
          final bool dipilih = kategori == _kategoriTerpilih;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(kategori),
              selected: dipilih,
              onSelected: (_) => _pilihKategori(kategori),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPencarian() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Cari judul pengumuman...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            _pencarian = value.toLowerCase();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portal Pengumuman TRPL (Percobaan ke-$_percobaan)'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: _muatUlang,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildPencarian(),
          _buildBarisFilter(),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<List<Announcement>>(
              future: _futurePengumuman,
              builder: (context, snapshot) {
                // ── Keadaan 1: LOADING ────────────────────────────────
                if (snapshot.connectionState != ConnectionState.done) {
                  return _buildMemuat();
                }
                // ── Keadaan 2: ERROR ─────────────────────────────────
                if (snapshot.hasError) {
                  return _buildGagal(snapshot.error!);
                }
                // ── Keadaan 3 & 4: KOSONG / BERHASIL ─────────────────
                final List<Announcement> semua =
                    snapshot.data ?? const <Announcement>[];

                final List<Announcement> tampil = semua
                    .where((Announcement item) {
                      final bool cocokKategori = _kategoriTerpilih == 'Semua' ||
                          item.category.toLowerCase() ==
                              _kategoriTerpilih.toLowerCase();

                      final bool cocokPencarian = _pencarian.isEmpty ||
                          item.title.toLowerCase().contains(_pencarian);

                      return cocokKategori && cocokPencarian;
                    })
                    .toList(growable: false);

                if (tampil.isEmpty) return _buildKosong();
                return _buildDaftar(tampil);
              },
            ),
          ),
        ],
      ),
    );
  }
}
