import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../domain/api_client/api_client.dart';
import '../models/movie.dart';

class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({
    Key? key,
    required this.popularMovies,
  }) : super(key: key);

  final List<Movie> popularMovies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 314,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: popularMovies.length,
        separatorBuilder: (context, index) =>
            const VerticalDivider(color: Colors.transparent, width: 15),
        itemBuilder: (context, index) {
          final Movie movie = popularMovies[index];
          final posterPath = movie.posterPath;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 190,
                  height: 250,
                  child: Image.network(
                    ApiClient.imageUrl(posterPath),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 180,
                child: Text(
                  movie.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: double.parse(movie.voteAverage),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 15,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(width: 5),
                  Text(movie.voteAverage,
                      style: const TextStyle(color: Colors.black45))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
