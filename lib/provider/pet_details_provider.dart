import 'package:flutter/cupertino.dart';
import 'package:pet_adoption_app_task/models/pet_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetDetailsProvider extends ChangeNotifier {
  //* providing the pet details to the other screens

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

  //* updating changes to the pet details

  void isAdoptedUpdate(bool isAdopted, int index) async {
    petDetailsMap.update(index, (value) {
      value[4] = isAdopted ? 'true' : 'false';
      value[5] = DateTime.now().toString();
      return value;
    });

    // Storing in Shared Prefs
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('petDetailsOf$index', petDetailsMap[index]!.toList());

    notifyListeners();
  }

  // * initializing the pet details at start of the app
  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();

    // loading the pet details from the shared prefs
    for (int i = 0; i < petDetailsMap.length; i++) {
      final petDetailsOf$i = prefs.getStringList('petDetailsOf$i');
      petDetailsMap.update(i, (value) {
        return petDetailsOf$i != null
            ? List.from(petDetailsOf$i)
            : petDetailsMap[i]!.toList();
      });
    }

    notifyListeners();
  }

  //* Data for the pet details
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
      '',
    ],
    4: [
      'Cat',
      'Lola',
      'https://media.istockphoto.com/photos/ginger-cat-picture-id1073475928?k=20&m=1073475928&s=612x612&w=0&h=50Dbbf5cz_-NaS74tLY64PubIWMPTu09DnUnKd8z1ag=',
      '6 mo.',
      'false',
      '',
    ],
    5: [
      'Dog',
      'Max',
      'https://thumbs.dreamstime.com/b/small-black-dog-looking-sideways-isolated-white-background-breedless-mixed-breed-canine-curious-222762519.jpg',
      '6 mo.',
      'false',
      '',
    ],
    6: [
      'Dog',
      'Charlie',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_ZhLBCD6wvUKiCqfJoMnikArR5hWygaGl9mmbm64TcAsSJ6Qya3MjnOCPfLmSP6fll6I&usqp=CAU',
      '6 mo.',
      'false',
      '',
    ],
    7: [
      'Cat',
      'Daizy',
      'https://media.istockphoto.com/photos/furry-british-cat-white-color-on-isolated-black-background-picture-id813499684?k=20&m=813499684&s=612x612&w=0&h=KYoDrE307ne0Emr3md0mbaKHmeor-E9bGA_gr4n08Tc=',
      '6 mo.',
      'false',
      '',
    ],
    8: [
      'Cat',
      'Bailey',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYAYwAsuxKXRE8Wt_csyXI3EXrAItShjClbypqU4diUIxECmGonnbEUMxuOAusijMQosQ&usqp=CAU',
      '6 mo.',
      'false',
      '',
    ],
    9: [
      'Cat',
      'Tucker',
      'https://i.scdn.co/image/ab67616d0000b2734835de0a1a906adc6246a3ba',
      '6 mo.',
      'false',
      '',
    ],
    10: [
      'Dog',
      'Jasper',
      'https://i.guim.co.uk/img/static/sys-images/Guardian/Pix/pictures/2014/11/8/1415466887744/Labrador-puppy-012.jpg?width=620&quality=85&fit=max&s=6ce4c2a6e28357cf66441d89a8a1c7ba',
      '6 mo.',
      'false',
      '',
    ],
    11: [
      'Dog',
      'Simba',
      'https://c.neh.tw/thumb/f/720/6608244248150016.jpg',
      '6 mo.',
      'false',
      '',
    ],
  };
}
