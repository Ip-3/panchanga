class AradaneModel {
  String date;
  String aradane;

  AradaneModel({
    required this.date,
    required this.aradane,
  });

  factory AradaneModel.fromJson(Map<String, dynamic> json) {
    return AradaneModel(date: '', aradane: '');
  }
  Map toJson() => {
        "date": date,
        "festival": aradane,
      };
}
