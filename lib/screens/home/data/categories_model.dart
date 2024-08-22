class CategoriesModel {
  final int? id;
  final String? name;
  final String? image;

  CategoriesModel({this.id, this.name, this.image});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
