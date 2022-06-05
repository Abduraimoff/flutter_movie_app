import 'package:flutter/material.dart';
import 'package:movie_app/domain/api_client/api_client.dart';
import 'package:movie_app/providers/movie_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieDetail = context.watch<MovieDetailProvider>().movieDetail;
    if (movieDetail == null) {
      return  const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.network(
                ApiClient.imageUrl(
                    'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}'),
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Container(
                padding: const EdgeInsets.only(top: 120),
                child: GestureDetector(
                  onTap: () async {
                    final id = movieDetail.trailerId;
                    final youtubeUrl = 'https://www.youtube.com/embed/$id';
                    if (await canLaunchUrl(Uri.parse(youtubeUrl))) {
                      await launchUrlString(youtubeUrl);
                    }
                  },
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.play_circle_outlined,
                          color: Colors.yellow,
                          size: 65,
                        ),
                        Text(
                          movieDetail.title.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 160),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overview'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movieDetail.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _InfoWidget(
                          title: 'RELEASE DATE',
                          subTitle: movieDetail.releaseDate,
                        ),
                        _InfoWidget(
                          title: 'RUNTIME',
                          subTitle: movieDetail.runtime,
                        ),
                        _InfoWidget(
                          title: 'BUDGET',
                          subTitle: movieDetail.budget,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const _InfoWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Colors.yellow[800],
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}
