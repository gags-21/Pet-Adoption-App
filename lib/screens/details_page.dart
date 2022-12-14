import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app_task/models/constants.dart';
import 'package:pet_adoption_app_task/models/pet_details_model.dart';
import 'package:pet_adoption_app_task/util/image_viewer.dart';
import 'package:provider/provider.dart';

import '../provider/pet_details_provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.pet, required this.index})
      : super(key: key);

  final PetDetails pet;
  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // Generating a random price for pet
  int price = Random().nextInt(10000) + 5000;

  late ConfettiController _confettiController;

  @override
  void initState() {
    // initializing the confetti controller
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    super.initState();
  }

  @override
  void dispose() {
    // disposing the confetti controller
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PetDetailsProvider>(builder: (context, petProvider, _) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // pet overview
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Hero(
                          tag: 'Pet Card Image ${widget.pet.image}',
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetImageViewer(
                                    imgUrl: widget.pet.image.toString(),
                                  ),
                                ),
                              ),
                              child: Image.network(
                                widget.pet.image.toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.pet.name.toString(),
                                style: headlineTextStyle),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(221, 233, 132, 132),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(90, 233, 132, 132),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    widget.pet.type.toString(),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black87,
                                    thickness: 1,
                                  ),
                                  Text(widget.pet.age.toString()),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(8.0).copyWith(left: 0),
                              child: Text('??? $price', style: priceTextStyle),
                            ),
                          ],
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
                            tabs: const [
                              Tab(text: 'Skills'),
                              Tab(text: 'History'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 200,
                          child: TabBarView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  '''
            ???   Skills one
            
            ???   Skills two
            
            ???   Skills three
            
            ???   Skills N''',
                                  textAlign: TextAlign.start,
                                  style:
                                      TextStyle(fontSize: 15, letterSpacing: 1),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  '''
            ????   History one
            
            ????   History two
            
            ????   History three
            
            ????   History N''',
                                  textAlign: TextAlign.start,
                                  style:
                                      TextStyle(fontSize: 15, letterSpacing: 1),
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
                title: !petProvider.isAdopted(widget.index)
                    ? 'Adopt Me'
                    : 'Adopted',
                onTap: !petProvider.isAdopted(widget.index)
                    ? () async {
                        // adoption functionality
                        petProvider.isAdoptedUpdate(true, widget.index);

                        // pet sound
                        final audioPlayer = AudioPlayer();
                        widget.pet.type == 'Dog'
                            ? audioPlayer.setSourceAsset('sounds/dog_bark.mp3')
                            : audioPlayer.setSourceAsset('sounds/cat_meow.mp3');
                        audioPlayer.resume();

                        //  play confetti animation
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
                                decoration: const BoxDecoration(
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
                                          child: Hero(
                                            tag:
                                                'Pet Card Image ${widget.pet.image.toString()}',
                                            child: Padding(
                                              padding: const EdgeInsets.all(25),
                                              child: Image.network(
                                                widget.pet.image.toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Text(
                                            'You???ve now adopted \n ???? ${petProvider.petName(widget.index)} ????',
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
                                          Navigator.popUntil(context,
                                              ModalRoute.withName('/'));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    : () {},
              ),
            ),
          ],
        );
      }),
    );
  }

  // Long Button
  GestureDetector longButton(BuildContext context,
      {required Function() onTap, required String title}) {
    return GestureDetector(
      key: title == 'Adopt Me'
          ? const Key('adoptButton')
          : const Key('adoptedButton'),
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
            style: const TextStyle(
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
