enum StatusPraktikum { berlangsung, akanDatang, selesai, tersedia }

class Course {
  final String name;
  final String waktu;
  final String ruang;
  final StatusPraktikum status;
  final String pesanStatus;

  const Course({
    required this.name,
    required this.waktu,
    required this.ruang,
    required this.status,
    required this.pesanStatus,
  });

  static List<Course> getSampleCourses() {
    return const [
      Course(
        name: 'Mobile Programming',
        waktu: '08.00 - 10.00',
        ruang: 'Lab 1',
        status: StatusPraktikum.berlangsung,
        pesanStatus: 'Sedang digunakan oleh praktikan',
      ),
      Course(
        name: 'Rekayasa Perangkat Lunak',
        waktu: '10.00 - 12.00',
        ruang: 'Lab 2',
        status: StatusPraktikum.akanDatang,
        pesanStatus: 'Sesi akan dimulai sebentar lagi',
      ),
      Course(
        name: 'Basis Data',
        waktu: '13.00 - 15.00',
        ruang: 'Lab 3',
        status: StatusPraktikum.selesai,
        pesanStatus: 'Sesi telah selesai',
      ),
      Course(
        name: 'Lab 2',
        waktu: 'Ruang tersedia di luar jadwal sesi',
        ruang: '',
        status: StatusPraktikum.tersedia,
        pesanStatus: 'Siap digunakan untuk praktikum lain',
      ),
    ];
  }
}