import 'package:flutter/material.dart';

class MonthFilterSelector extends StatelessWidget {
  final Function toggleFilterCallback;

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

  MonthFilterSelector({super.key, required this.toggleFilterCallback});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(spacing: 5.0, children: [
          ...months
              .map((pl) => FilterChip(
                    label: Text(pl),
                    backgroundColor: Colors.grey,
                    selectedColor: Colors.grey,
                    labelStyle: const TextStyle(color: Colors.black),
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Color.fromARGB(0, 4, 1, 1)),
                    onSelected: (bool selected) {
                      toggleFilterCallback(pl, selected);
                    },
                  ))
              .toList()
        ]),
      ),
    ]));
  }
}
