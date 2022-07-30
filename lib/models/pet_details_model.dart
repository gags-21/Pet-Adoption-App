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
  DateTime? adoptedAt;
  String? isAdopted;

  factory PetDetails.fromList(List<String> list) => PetDetails(
        type: list[0],
        name: list[1],
        image: list[2],
        age: list[3],
        isAdopted: list[4],
        adoptedAt: DateTime.tryParse(list[5]),
      );
}
