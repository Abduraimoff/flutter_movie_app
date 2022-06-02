import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/providers/genre_provider.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/genre.dart';
import '../widgets/genre_item.dart';
import '../widgets/popular_movies_widget.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedGenre;
  const BuildWidgetCategory({Key? key, this.selectedGenre = 28})
      : super(key: key);

  @override
  State<BuildWidgetCategory> createState() => _BuildWidgetCategory();
}

class _BuildWidgetCategory extends State<BuildWidgetCategory> {
  late int selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
    context.read<GenreProvider>().loadGenres();
    context.read<MovieProvider>().loadPopularMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<GenreProvider>().genres.isEmpty) {
      return const SizedBox.shrink();
    }
    List<Genre> genres = context.watch<GenreProvider>().genres;
    List<Movie> popularMovies = context.watch<MovieProvider>().popularMovies;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            separatorBuilder: (context, index) =>
                const VerticalDivider(color: Colors.transparent, width: 5),
            itemBuilder: (context, index) {
              final Genre genre = genres[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Genre genre = genres[index];
                        selectedGenre = genre.id;
                      });
                    },
                    child:
                        GenreItem(genre: genre, selectedGenre: selectedGenre),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'popular movies'.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 10),
        PopularMoviesWidget(popularMovies: popularMovies),
      ],
    );
  }
}
