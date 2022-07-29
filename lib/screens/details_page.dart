import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hover_widget/hover_widget.dart';
import 'package:pet_adoption_app_task/models/constants.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.pet}) : super(key: key);

  final List<String>? pet;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int price = Random().nextInt(10000) + 5000;
  late ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              // pet overview
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Hero(
                      tag: 'Pet Card Image ${widget.pet![2]}',
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Image.network(
                          widget.pet![2],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.pet![1], style: headlineTextStyle),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(221, 233, 132, 132),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(90, 233, 132, 132),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(widget.pet![0]),
                                VerticalDivider(
                                  color: Colors.black87,
                                  thickness: 1,
                                ),
                                Text(widget.pet![3]),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(8.0).copyWith(left: 0),
                            child: Text('₹ $price', style: priceTextStyle),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: TabBar(
                        labelColor: accentColor,
                        indicatorColor: accentColor,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: 'Skills'),
                          Tab(text: 'History'),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              '''
✅   Skills one

✅   Skills two

✅   Skills three

✅   Skills N''',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, letterSpacing: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              '''
🕐   History one

🕐   History two

🕐   History three

🕐   History N''',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Confetti Animation
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.directional,
              blastDirection: 180,
              numberOfParticles: 20,
              minBlastForce: 15,
              // emissionFrequency: 0.5,
              // particleDrag: 0.5,
              // shouldLoop: false,
              colors: confettiColors,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.directional,
              blastDirection: 180 + 45,
              numberOfParticles: 20,
              minBlastForce: 15,
              // emissionFrequency: 0.5,
              // particleDrag: 0.5,
              // shouldLoop: false,
              colors: confettiColors,
            ),
          ),

          // Adoption Button
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width * 0.15,
            right: MediaQuery.of(context).size.width * 0.15,
            child: longButton(
              context,
              title: 'Adopt Me',
              onTap: () {
                // confetti & logic
                setState(() {
                  _confettiController.play();
                });

                // bottom sheet
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.black38,
                  builder: (BuildContext cn) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  // TODO : remove Hero if not userfull
                                  child: Hero(
                                    tag: 'Pet Card Image ${widget.pet![2]}',
                                    child: Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Image.network(
                                        widget.pet![2],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    'You’ve now adopted \n 💙 <pet_name> 💙',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: blackTextColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, bottom: 15),
                              child: longButton(
                                context,
                                title: 'Home',
                                onTap: () {
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector longButton(BuildContext context,
      {required Function() onTap, required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(5),
        ),
        // width: MediaQuery.of(context).size.width * 0.5,

        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
