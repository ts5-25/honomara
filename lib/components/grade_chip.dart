import 'package:flutter/material.dart';

class GradeFilterChip extends StatelessWidget {
  final String grade;
  final List<String> selectedGrade;
  final Function(List<String>) onSelectionChanged;

  GradeFilterChip({
    required this.grade,
    required this.selectedGrade,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        grade,
        style: TextStyle(
          color: selectedGrade.contains(grade) ? Colors.white : Colors.grey[600],
        ),
      ),
      backgroundColor: Colors.white,
      selectedColor: Colors.grey[600],
      showCheckmark: false,
      selected: selectedGrade.contains(grade),
      onSelected: (bool value) {
        if (value) {
          if (!selectedGrade.contains(grade)) {
            selectedGrade.add(grade);
          }
        } else {
          selectedGrade.removeWhere((filterFilter) => filterFilter == grade);
        }
        onSelectionChanged(selectedGrade);
      },
    );
  }
}