class TarpanaModel {
  String date;
  String tarpana;

  TarpanaModel({
    required this.date,
    required this.tarpana,
  });

  factory TarpanaModel.fromJson(Map<String, dynamic> json) {
    return TarpanaModel(date: '', tarpana: '');
  }
  Map toJson() => {
        "date": date,
        "tarpana": tarpana,
      };
}
