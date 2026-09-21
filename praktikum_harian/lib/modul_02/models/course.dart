class Course {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final double progress;
  final String room;
  final String kategori;

  const Course(
      {required this.code,
      required this.name,
      required this.lecturer,
      required this.sks,
      required this.progress,
      this.room = 'Lab Komputer 3',
      required this.kategori});

  static List<Course> getSampleCourses() {
    return const [
      Course(
        code: 'TRPL201',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Sepyan Purnama Kristanto',
        sks: 4,
        progress: 0.25,
        room: 'Lab TUK',
        kategori: 'Praktikum',
      ),
      Course(
        code: 'TRPL202',
        name: 'Metode dan Model Pengembangan Perangkat Lunak',
        lecturer: 'Bu EMa',
        sks: 3,
        progress: 0.40,
        room: 'GKT G7.08',
        kategori: 'Teori',
      ),
      Course(
        code: 'TRPL203',
        name: 'Pancasila',
        lecturer: 'Bu Ninik',
        sks: 3,
        progress: 0.60,
        room: 'GKT G1.03',
        kategori: 'Teori',
      ),
      Course(
        code: 'TRPL204',
        name: 'Basis Data Lanjut',
        lecturer: 'Bu Eka Mistiko',
        sks: 2,
        progress: 0.15,
        room: 'Lab Program2',
        kategori: 'Praktikum',
      ),
    ];
  }
}
