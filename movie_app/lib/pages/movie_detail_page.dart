import 'package:flutter/material.dart';
import 'package:movie_app/domain/api_client/api_client.dart';
import 'package:movie_app/providers/movie_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/cast.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieDetail = context.watch<MovieDetailProvider>().movieDetail;
    if (movieDetail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                        style: const TextStyle(
                          height: 1.3,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 25),
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
                      const SizedBox(height: 30),
                      Text(
                        'Casts'.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieDetail.castList?.length ?? 0,
                          separatorBuilder: (context, index) =>
                              const VerticalDivider(
                                  color: Colors.transparent, width: 5),
                          itemBuilder: (context, index) {
                            Cast cast = movieDetail.castList![index];
                            final profilePath = cast.profilePath;
                            return Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  elevation: 3,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: profilePath != null
                                          ? Image.network(
                                              'https://image.tmdb.org/t/p/w200/$profilePath',
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                ),
                                Text(
                                  cast.name.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 8,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
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
