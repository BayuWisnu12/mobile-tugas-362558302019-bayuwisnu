// modul_02/ruangpraktikum.dart
import 'package:flutter/material.dart';
import 'models/ruang_praktikum_course.dart';
import 'study_case/course_card.dart';

class ruangpraktikum extends StatefulWidget {
  const ruangpraktikum({super.key});

  @override
  State<ruangpraktikum> createState() => _RuangPraktikumState();
}

class _RuangPraktikumState extends State<ruangpraktikum> {
  final List<Course> _courses = Course.getSampleCourses();
  
  bool _isDarkMode = false; 

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        fontFamily: 'Roboto',
      ),
      child: Scaffold(
        backgroundColor: _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(), 
                const SizedBox(height: 24),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                      
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 200, 
                        ),
                        itemCount: _courses.length,
                        itemBuilder: (context, index) {
                          return CourseCard(course: _courses[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ruang Praktikum Hari Ini',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
              color: _isDarkMode ? Colors.amber : Colors.grey.shade800,
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildChip(Icons.calendar_month, '3 sesi', Colors.blue.shade100, Colors.blue.shade800),
            const SizedBox(width: 8),
            _buildChip(Icons.door_front_door, '1 ruang tersedia', Colors.green.shade100, Colors.green.shade800),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(IconData icon, String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor, 
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}