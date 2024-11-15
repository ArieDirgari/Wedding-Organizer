class Souvenir {
  final String image;
  final String name;
  Souvenir({
    required this.image,
    required this.name,
  });
  factory Souvenir.fromJson(Map<String, dynamic> data) {
    return Souvenir(
        name: data['name'],
        image: data['image']
    );
  }
}
