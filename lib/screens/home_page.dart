import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pet_adoption_app_task/provider/pet_details_provider.dart';
import 'package:pet_adoption_app_task/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../models/constants.dart';
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

  // Main Grid View
  GridView petCardGrid(ThemeMode appTheme, PetDetailsProvider petProvider) {
    final isLight = appTheme == ThemeMode.light;
    return GridView.count(
      crossAxisCount: 2,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      children: List.generate(
        petProvider.totalPets,
        (index) {
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
                  child: petCard(isLight, index, petProvider),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Pet Card
  Padding petCard(bool isLight, int index, PetDetailsProvider petProvider) {
    final petDetails = petProvider.petDetails(index);
    return Padding(
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
                      tag: 'Pet Card Image ${petDetails.image}',
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Image.network(
                          petDetails.image.toString(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(petDetails.name.toString()),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    height: 35,
                    color: isLight ? lightCardBottomColor : darkCardBottomColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(petDetails.type.toString()),
                        VerticalDivider(
                          color: isLight ? Colors.black : Colors.white,
                          thickness: 1,
                        ),
                        Text(petDetails.age.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              petProvider.isAdopted(index)
                  ? Container(
                      color: isLight
                          ? const Color.fromARGB(82, 255, 255, 255)
                          : const Color.fromARGB(121, 0, 0, 0),
                      child: Center(
                        child: Container(
                          color: isLight
                              ? const Color.fromARGB(207, 78, 78, 78)
                              : Colors.white.withOpacity(0.8).withOpacity(0.8),
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
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
