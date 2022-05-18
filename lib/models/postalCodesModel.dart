class PostalCodeModel {
  final String postalCode_ID;
  final String city_ID;
  final String postalCode;

  PostalCodeModel._(
      {required this.postalCode_ID,
      required this.city_ID,
      required this.postalCode});

  factory PostalCodeModel.fromJson(Map<String, dynamic> json) {
    return new PostalCodeModel._(
      postalCode_ID: json['PostalCode_ID'],
      city_ID: json['City_ID'],
      postalCode: json['PostalCode'],
    );
  }
}
