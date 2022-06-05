import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:provider/provider.dart';

import '../domain/api_client/api_client.dart';
import '../providers/movie_detail_provider.dart';
import '../providers/movie_provider.dart';

class CustomCarouselWidget extends StatelessWidget {
  const CustomCarouselWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: context.watch<MovieProvider>().movies.length,
      itemBuilder: (BuildContext context, int index, _) {
        final movie = context.watch<MovieProvider>().movies[index];
        final posterPath = movie.posterPath;
        return GestureDetector(
          onTap: () {
            var route = MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => MovieDetailProvider(movie.id.toString())
                  ..loadMovieDetail(movie.id.toString()),
                child: const MovieDetailPage(),
              ),
            );
            Navigator.push(context, route);
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    ApiClient.imageUrl(posterPath),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 15),
                child: Text(
                  movie.title.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: true,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
      ),
    );
  }
}
