class User {
  final String userId;
  final String ?first_Name;
  final String? last_Name;
  final String?user_Type;

  User._(
      {required this.userId,
         this.first_Name,
         this.last_Name,
         this.user_Type});
  User(
      {
        required this.userId,
        this.first_Name,
        this.last_Name,
        this.user_Type});
  factory User.fromJson(Map<String, dynamic> json) {
    return new User._(
      userId: json['User_ID'],
      first_Name: json['First_Name'],
      last_Name: json['Last_Name'],
      user_Type: json['User_Type'],
    );
  }
}