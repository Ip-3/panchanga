class AradaneModel {
  String date;
  String day;
  String aradane;

  AradaneModel({
    required this.date,
    required this.day,
    required this.aradane,
  });

  factory AradaneModel.fromJson(Map<String, dynamic> json) {
    return AradaneModel(date: '', day: '', aradane: '');
  }
  Map toJson() => {
        "date": date,
        "day": day,
        "festival": aradane,
      };
}
