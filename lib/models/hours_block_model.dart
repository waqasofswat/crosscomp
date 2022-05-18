class HoursBlock {
  final String day_name;
  final String start;
  final String end;

  HoursBlock(
      {required this.day_name,
        required this.start,
        required this.end});
  String getdayname(){
    return day_name;
  }
  String getstart(){
    return start;
  }
  String getend(){
    return end;
  }

  Map toJson() {
    return {'day_name': day_name, 'start': start, 'end': end};
  }
/*
  factory HoursBlock.fromJson(Map<String, dynamic> json) {
    return new HoursBlock._(
      postalCode_ID: json['PostalCode_ID'],
      city_ID: json['City_ID'],
      postalCode: json['PostalCode'],
    );
  }*/
}
