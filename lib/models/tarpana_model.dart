class TarpanaModel {
  String date;
  String day;
  String tarpana;

  TarpanaModel({
    required this.date,
    required this.day,
    required this.tarpana,
  });

  factory TarpanaModel.fromJson(Map<String, dynamic> json) {
    return TarpanaModel(date: '', day: '', tarpana: '');
  }
  Map toJson() => {
        "date": date,
        "day": day,
        "tarpana": tarpana,
      };
}
