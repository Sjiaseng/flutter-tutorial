class AddressModel {
  final String street;
  final String city;
  final String state;
  final String zip;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      street: map['street'],
      city: map['city'],
      state: map['state'],
      zip: map['zip'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zip': zip,
    };
  }
}