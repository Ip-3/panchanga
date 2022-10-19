class FestivalModel {
  String date;
  String day;
  String festivals;

  FestivalModel({
    required this.date,
    required this.day,
    required this.festivals,
  });

  factory FestivalModel.fromJson(Map<String, dynamic> json) {
    return FestivalModel(date: '', day: '', festivals: '');
  }
  Map toJson() => {
        "date": date,
        "day": day,
        "festivals": festivals,
      };
}
