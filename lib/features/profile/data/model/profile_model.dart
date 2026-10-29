class UserProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String country;
  final String city;
  final String address;

  const UserProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.country,
    required this.city,
    required this.address,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final addressData = json['address'] as Map<String, dynamic>? ?? {};

    return UserProfileModel(
      id: json['id'] as int? ?? 0,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      country: addressData['country'] as String? ?? '',
      city: addressData['city'] as String? ?? '',
      address: addressData['address'] as String? ?? '',
    );
  }
}
