import 'package:flutter/material.dart';

import '../models/person.dart';

class TrendingPeopleWidget extends StatelessWidget {
  const TrendingPeopleWidget({
    Key? key,
    required this.people,
  }) : super(key: key);

  final List<Person> people;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: people.length,
        separatorBuilder: (context, index) =>
            const VerticalDivider(color: Colors.transparent, width: 5),
        itemBuilder: (context, index) {
          final person = people[index];
          final profilePath = person.profilePath;
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
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              Text(
                person.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black45,
                ),
              ),
              Text(
                person.knowForDepartment.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black45,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
