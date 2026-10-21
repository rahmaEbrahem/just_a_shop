class RegisterReqModel {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  Address? address;

  RegisterReqModel({
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.password,
    this.address,
  });
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      if (address != null)
        'address': {
          'address': address!.address,
          'city': address!.city,
          'country': address!.country,
        },
    };
  }
}

class Address {
  String? address;
  String? city;
  String? country;

  Address({this.address, this.city, this.country});
}
