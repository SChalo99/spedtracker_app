import 'package:flutter/material.dart';

class MonthFilterSelector extends StatelessWidget {
  final Function toggleFilterCallback;
  final Set<String> filters;
  final List months = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Oct',
    'Nov',
    'Dic'
  ];

  MonthFilterSelector({
    super.key,
    required this.toggleFilterCallback,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
            spacing: 5.0,
            children: months.map((month) {
              return FilterChip(
                label: Text(month.toUpperCase()),
                backgroundColor: Colors.grey,
                selectedColor: Colors.green,
                labelStyle: const TextStyle(color: Colors.black),
                shape: const StadiumBorder(),
                side: const BorderSide(color: Color.fromARGB(0, 4, 1, 1)),
                selected: filters.contains(month),
                onSelected: (bool selected) {
                  toggleFilterCallback(month, selected);
                },
              );
            }).toList()),
      ),
    ]));
  }
}
