// widgets/course_card.dart
import 'package:flutter/material.dart';
import '../models/ruang_praktikum_course.dart'; 

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  Color _getPrimaryColor() {
    switch (course.status) {
      case StatusPraktikum.berlangsung: return Colors.blue;
      case StatusPraktikum.akanDatang: return Colors.orange.shade300;
      case StatusPraktikum.selesai: return Colors.grey;
      case StatusPraktikum.tersedia: return Colors.green;
    }
  }

  String _getStatusText() {
    switch (course.status) {
      case StatusPraktikum.berlangsung: return 'Berlangsung';
      case StatusPraktikum.akanDatang: return 'Akan datang';
      case StatusPraktikum.selesai: return 'Selesai';
      case StatusPraktikum.tersedia: return 'Tersedia';
    }
  }

  IconData _getStatusIcon() {
    switch (course.status) {
      case StatusPraktikum.berlangsung: return Icons.people;
      case StatusPraktikum.akanDatang: return Icons.access_time;
      case StatusPraktikum.selesai: return Icons.check_circle;
      case StatusPraktikum.tersedia: return Icons.door_front_door;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final primaryColor = _getPrimaryColor();
    final bgColor = primaryColor.withValues(alpha: isDark ? 0.2 : 0.1); 
    
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade700;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  course.name,
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: course.status == StatusPraktikum.akanDatang || course.status == StatusPraktikum.selesai 
                      ? primaryColor.withValues(alpha: isDark ? 0.3 : 0.2) 
                      : primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(),
                  style: TextStyle(
                    color: course.status == StatusPraktikum.akanDatang || course.status == StatusPraktikum.selesai 
                        ? (isDark ? Colors.white : Colors.black87) 
                        : Colors.white, 
                    fontSize: 12, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Icon(course.status == StatusPraktikum.tersedia ? Icons.door_front_door : Icons.access_time, size: 16, color: secondaryTextColor),
              const SizedBox(width: 8),
              Expanded(child: Text(course.waktu, style: TextStyle(color: secondaryTextColor))),
            ],
          ),
          
          if (course.ruang.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: secondaryTextColor),
                const SizedBox(width: 8),
                Text(course.ruang, style: TextStyle(color: secondaryTextColor)),
              ],
            ),
          ],
          
          const Spacer(), 
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(_getStatusIcon(), size: 20, color: primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    course.pesanStatus,
                    style: TextStyle(
                      color: isDark && primaryColor == Colors.blue ? Colors.lightBlue.shade300 : primaryColor, 
                      fontWeight: FontWeight.w600, 
                      fontSize: 13
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}