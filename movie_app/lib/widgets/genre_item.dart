import 'package:flutter/material.dart';

import '../models/genre.dart';

class GenreItem extends StatelessWidget {
  const GenreItem({
    Key? key,
    required this.genre,
    required this.selectedGenre,
  }) : super(key: key);

  final Genre genre;
  final int selectedGenre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(25),
        color: (genre.id == selectedGenre)
            ? Colors.black45
            : Colors.white,
      ),
      child: Text(
        genre.name.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: (genre.id == selectedGenre)
              ? Colors.white
              : Colors.black45,
        ),
      ),
    );
  }
}