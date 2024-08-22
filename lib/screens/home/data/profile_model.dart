class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String image;
  final String phone;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      phone: json['phone'],
    );
  }
}
