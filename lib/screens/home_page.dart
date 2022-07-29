import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hover_widget/hover_widget.dart';
import 'package:pet_adoption_app_task/provider/pet_details_provider.dart';
import 'package:pet_adoption_app_task/provider/theme_provider.dart';
import 'package:pet_adoption_app_task/screens/history_page.dart';
import 'package:provider/provider.dart';

import '../models/constants.dart';
import '../models/pet_details_model.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(context).themeMode;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<PetDetailsProvider>(
                builder: (context, petProvider, _) {
              return AnimationLimiter(
                  child: petCardGrid(appTheme, petProvider));
            }),
          ),
        ],
      ),
    );
  }

  GridView petCardGrid(ThemeMode appTheme, PetDetailsProvider petProvider) {
    final isLight = appTheme == ThemeMode.light;
    return GridView.count(
      crossAxisCount: 2,
      physics: BouncingScrollPhysics(),
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 7,
      //   mainAxisSpacing: 7,
      // ),
      padding: EdgeInsets.all(10),
      children: List.generate(
        petProvider.totalPets,
        (index) {
          // Pet Card
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: SlideAnimation(
              verticalOffset: 100,
              delay: Duration(milliseconds: (index * 100).toInt()),
              child: FadeInAnimation(
                delay: Duration(milliseconds: (index * 100).toInt()),
                child: GestureDetector(
                  onTap: () {
                    !petProvider.isAdopted(index)
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                index: index,
                                pet: petProvider.petDetails(index),
                              ),
                            ),
                          )
                        : null;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                          color: isLight
                              ? lightCardColors[Random().nextInt(4)]
                              : darkCardColors[Random().nextInt(4)],
                        ),
                        height: 150,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag:
                                        'Pet Card Image ${petDetailsMap[index]![2]}',
                                    child: Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Image.network(
                                        petDetailsMap[index]![2],
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      petProvider.petName(index).toString()),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  height: 35,
                                  color: isLight
                                      ? lightCardBottomColor
                                      : darkCardBottomColor,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(petDetailsMap[index]![0]),
                                      VerticalDivider(
                                        color: isLight
                                            ? Colors.black
                                            : Colors.white,
                                        thickness: 1,
                                      ),
                                      Text(petDetailsMap[index]![3]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            petProvider.isAdopted(index)
                                ? Container(
                                    color: isLight
                                        ? Color.fromARGB(82, 255, 255, 255)
                                        : Color.fromARGB(121, 0, 0, 0),
                                    child: Center(
                                      child: Container(
                                        color: isLight
                                            ? Color.fromARGB(207, 78, 78, 78)
                                            : Colors.white
                                                .withOpacity(0.8)
                                                .withOpacity(0.8),
                                        width: double.infinity,
                                        height: 50,
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Already Adopted',
                                            style: TextStyle(
                                                color: isLight
                                                    ? whiteTextColor
                                                    : blackTextColor),
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query == '') {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final petProvider = Provider.of<PetDetailsProvider>(context);
    List petNames = petProvider.petNamesList();
    List name = [
      for (int i = 0; i < petNames.length; i++)
        if (petNames[i].toString().toLowerCase().contains(query.toLowerCase()))
          petNames[i]
    ];
    // List suggestions = name.where((searched) {
    //   searched = searched.toLowerCase();
    //   query = query.toLowerCase();
    //   return searched.contains(query);
    // }).toList();
    return ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                petProvider
                    .petDetails(petNames.indexOf(name[index]))
                    .image
                    .toString(),
              ),
            ),
            title: Text(name[index]),
            onTap: () {
              showResults(context);
              petProvider.petName(index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    index: petNames.indexOf(name[index]),
                    pet: petProvider.petDetails(petNames.indexOf(name[index])),
                  ),
                ),
              );
            },
          );
        });
  }
}
