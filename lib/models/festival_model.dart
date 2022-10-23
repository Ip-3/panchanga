class FestivalModel {
  String date;
  String month;
  String year;
  String festivals;

  FestivalModel({
    required this.date,
    required this.month,
    required this.year,
    required this.festivals,
  });

  factory FestivalModel.fromJson(Map<String, dynamic> json) {
    return FestivalModel(date: '', festivals: '', month: '', year: '');
  }
  Map toJson() => {
        "date": date,
        "month": month,
        "year": year,
        "festivals": festivals,
      };
}
