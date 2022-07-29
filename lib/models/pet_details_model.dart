class PetDetails {
  PetDetails({
    required this.name,
    required this.type,
    required this.age,
    required this.image,
    this.adoptedAt,
    required this.isAdopted,
  });

  String? name;
  String? type;
  String? age;
  String? image;
  String? adoptedAt;
  String? isAdopted;

  factory PetDetails.fromList(List<String> list) => PetDetails(
        type: list[0],
        name: list[1],
        image: list[2],
        age: list[3],
        isAdopted: list[4],
        adoptedAt: list[5],
      );

  // Map<String, dynamic> toJson() => {
  //       "name": name == null ? null : name,
  //       "type": type == null ? null : type,
  //       "age": age == null ? null : age,
  //       "image": image == null ? null : image,
  //       "adoptedAt": adoptedAt == null ? null : adoptedAt!.toIso8601String(),
  //       "isAdopted": isAdopted == null ? null : isAdopted,
  //     };
}

Map<int, List<String>> petDetailsMap = {
  0: [
    'Cat',
    'Bella',
    'https://images.unsplash.com/photo-1595433707802-6b2626ef1c91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
    '6 mo.',
    'false',
  ],
  1: [
    'Dog',
    'Milo',
    'https://us.123rf.com/450wm/isselee/isselee1903/isselee190300561/119670302-golden-retriever-3-months-old-sitting-in-front-of-white-background.jpg?ver=6',
    '6 mo.',
    'false',
  ],
  2: [
    'Dog',
    'Milo',
    'https://media.istockphoto.com/photos/beagle-5-years-old-sitting-in-front-of-white-background-picture-id962855368?b=1&k=20&m=962855368&s=612x612&w=0&h=7ioz-J7lnJjKO5t5pVsXz-5jAtAbG2jpam1viJ3Rw_4=',
    '6 mo.',
    'false',
  ],
  3: [
    'Cat',
    'Zoe',
    'https://thumbs.dreamstime.com/b/single-black-kitten-white-background-big-eyes-one-90775523.jpg',
    '6 mo.',
    'true',
    'Testing',
  ],
  4: [
    'Cat',
    'Lola',
    'https://media.istockphoto.com/photos/ginger-cat-picture-id1073475928?k=20&m=1073475928&s=612x612&w=0&h=50Dbbf5cz_-NaS74tLY64PubIWMPTu09DnUnKd8z1ag=',
    '6 mo.',
    'false',
  ],
};
