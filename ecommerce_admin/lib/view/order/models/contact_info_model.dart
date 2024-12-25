class ContactInfoModel {
  final String phone;
  final String email;

  ContactInfoModel({
    required this.phone,
    required this.email,
  });

  factory ContactInfoModel.fromMap(Map<String, dynamic> map) {
    return ContactInfoModel(
      phone: map['phone'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
    };
  }
}
