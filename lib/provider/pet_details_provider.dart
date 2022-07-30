import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pet_adoption_app_task/models/pet_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetDetailsProvider extends ChangeNotifier {
  // PetDetails pr = PetDetails.fromList(petDetailsMap[1]!.toList());

  // providing the pet details to the other screens

  int get totalPets => petDetailsMap.length;

  PetDetails petDetails(int index) {
    return PetDetails.fromList(petDetailsMap[index]!.toList());
  }

  String petName(int index) {
    PetDetails pr = PetDetails.fromList(petDetailsMap[index]!.toList());
    return pr.name.toString();
  }

  bool isAdopted(int index) {
    PetDetails pr = PetDetails.fromList(petDetailsMap[index]!.toList());
    return pr.isAdopted == 'true' ? true : false;
  }

  List<PetDetails> adoptedPets() {
    List<PetDetails> adoptedPets = [];
    for (int i = 0; i < petDetailsMap.length; i++) {
      PetDetails pr = PetDetails.fromList(petDetailsMap[i]!.toList());
      if (pr.isAdopted == 'true') {
        adoptedPets.add(pr);
      }
    }
    adoptedPets.sort((a, b) => b.adoptedAt!.compareTo(a.adoptedAt!));
    return adoptedPets;
  }

  List<String> petNamesList() {
    List<String> petNames = [];
    for (int i = 0; i < petDetailsMap.length; i++) {
      PetDetails pr = PetDetails.fromList(petDetailsMap[i]!.toList());
      petNames.add(pr.name.toString());
    }
    return petNames;
  }

  // updating changes to the pet details

  void isAdoptedUpdate(bool isAdoptedd, int index) async {
    petDetailsMap.update(index, (value) {
      value[4] = isAdoptedd ? 'true' : 'false';
      value[5] = DateTime.now().toString();
      // '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
      return value;
    });

    // Shared Prefs
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String encodedDetailsMap = json.encode(petDetailsMap);
    prefs.setStringList('petDetailsOf$index', petDetailsMap[index]!.toList());

    // pr.isAdopted = isAdoptedd ? 'true' : 'false';
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final encodedDetailsMap = _prefs.getString('allPetDetails');
    // petDetailsMap = json.decode(encodedDetailsMap ?? petDetailsMap.toString());
    // prefs.clear();
    for (int i = 0; i < 5; i++) {
      final petDetailsOf$i = prefs.getStringList('petDetailsOf$i');
      petDetailsMap.update(i, (value) {
        return petDetailsOf$i != null
            ? List.from(petDetailsOf$i)
            : petDetailsMap[i]!.toList();
      });
    }

    notifyListeners();
  }

  static Map<int, List<String>> petDetailsMap = {
    0: [
      'Cat',
      'Bella',
      'https://images.unsplash.com/photo-1595433707802-6b2626ef1c91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
      '6 mo.',
      'false',
      '',
    ],
    1: [
      'Dog',
      'Milo',
      'https://us.123rf.com/450wm/isselee/isselee1903/isselee190300561/119670302-golden-retriever-3-months-old-sitting-in-front-of-white-background.jpg?ver=6',
      '6 mo.',
      'false',
      '',
    ],
    2: [
      'Dog',
      'Milos',
      'https://media.istockphoto.com/photos/beagle-5-years-old-sitting-in-front-of-white-background-picture-id962855368?b=1&k=20&m=962855368&s=612x612&w=0&h=7ioz-J7lnJjKO5t5pVsXz-5jAtAbG2jpam1viJ3Rw_4=',
      '6 mo.',
      'false',
      '',
    ],
    3: [
      'Cat',
      'Zoe',
      'https://thumbs.dreamstime.com/b/single-black-kitten-white-background-big-eyes-one-90775523.jpg',
      '6 mo.',
      'false',
      'Testing',
    ],
    4: [
      'Cat',
      'Lola',
      'https://media.istockphoto.com/photos/ginger-cat-picture-id1073475928?k=20&m=1073475928&s=612x612&w=0&h=50Dbbf5cz_-NaS74tLY64PubIWMPTu09DnUnKd8z1ag=',
      '6 mo.',
      'false',
      '',
    ],
  };
}
