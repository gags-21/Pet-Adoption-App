import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hover_widget/hover_widget.dart';
import 'package:pet_adoption_app_task/screens/history_page.dart';

import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Map<int, List<String>> imageUrls = {
    0: [
      'Cat',
      'Bella',
      'https://images.unsplash.com/photo-1595433707802-6b2626ef1c91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
      '6 mo.',
    ],
    1: [
      'Dog',
      'Milo',
      'https://us.123rf.com/450wm/isselee/isselee1903/isselee190300561/119670302-golden-retriever-3-months-old-sitting-in-front-of-white-background.jpg?ver=6',
      '6 mo.',
    ],
    2: [
      'Dog',
      'Milo',
      'https://media.istockphoto.com/photos/beagle-5-years-old-sitting-in-front-of-white-background-picture-id962855368?b=1&k=20&m=962855368&s=612x612&w=0&h=7ioz-J7lnJjKO5t5pVsXz-5jAtAbG2jpam1viJ3Rw_4=',
      '6 mo.',
    ],
    3: [
      'Cat',
      'Zoe',
      'https://thumbs.dreamstime.com/b/single-black-kitten-white-background-big-eyes-one-90775523.jpg',
      '6 mo.',
    ],
    4: [
      'Cat',
      'Lola',
      'https://media.istockphoto.com/photos/ginger-cat-picture-id1073475928?k=20&m=1073475928&s=612x612&w=0&h=50Dbbf5cz_-NaS74tLY64PubIWMPTu09DnUnKd8z1ag=',
      '6 mo.',
    ],
  };

  List<Color> cardColors = [
    Color(0xFFF4BFBF),
    Color(0xFFFFD9C0),
    Color(0xFF9CB4CC),
    Color(0xFF748DA6),
  ];
  int colorChooser = Random().nextInt(4);

  // Map<String, dynamic> pets = {
  //   'Dog': [
  //     imageUrls[0],
  //     imageUrls[1],
  //   ],
  //   'Cats':[
  //     imageUrls[2],
  //     imageUrls[3],
  //     imageUrls[4],
  //   ],

  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AnimationLimiter(child: petCardGrid()),
          ),
        ],
      ),
    );
  }

  GridView petCardGrid() {
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
        5,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          pet: imageUrls[index],
                        ),
                      ),
                    );
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
                          color: cardColors[Random().nextInt(4)],
                        ),
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: 'Pet Card Image ${imageUrls[index]![2]}',
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Image.network(
                                    imageUrls[index]![2],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(imageUrls[index]![1]),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              height: 25,
                              color: Color.fromARGB(111, 255, 255, 255),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(imageUrls[index]![0]),
                                  VerticalDivider(
                                    color: Colors.black54,
                                    thickness: 1,
                                  ),
                                  Text(imageUrls[index]![3]),
                                ],
                              ),
                            ),
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
  Widget buildResults(BuildContext context) =>
      IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));

  @override
  Widget buildSuggestions(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
  }
}
