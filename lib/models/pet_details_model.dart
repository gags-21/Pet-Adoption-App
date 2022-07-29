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
  int? age;
  String? image;
  DateTime? adoptedAt;
  bool? isAdopted;
}
