import 'package:flutter/material.dart';
import 'package:movie_app/models/person.dart';
import 'package:movie_app/providers/genre_provider.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import '../providers/person_provider.dart';
import '../widgets/custom_carousel_widget.dart';
import '../widgets/trending_people_widget.dart';
import 'category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieProvider>().loadMovies();
    context.read<PersonProvider>().loadPeople();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GenreProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(Icons.menu, color: Colors.black45),
          centerTitle: true,
          title: Text(
            'Movies-db',
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.black45,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: const CircleAvatar(),
            ),
          ],
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (context.watch<MovieProvider>().movies.isEmpty) {
      return const SizedBox.shrink();
    }

    List<Person> people = context.watch<PersonProvider>().people;

    return LayoutBuilder(
      builder: ((context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.minHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const CustomCarouselWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          const BuildWidgetCategory(),
                          Text(
                            'Trending people of this week'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TrendingPeopleWidget(people: people)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
