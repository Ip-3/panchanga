class EkadashiModel {
  String date;
  String day;
  String ekadashi;

  EkadashiModel({
    required this.date,
    required this.day,
    required this.ekadashi,
  });

  factory EkadashiModel.fromJson(Map<String, dynamic> json) {
    return EkadashiModel(date: '', day: '', ekadashi: '');
  }
  Map toJson() => {
        "date": date,
        "day": day,
        "festival": ekadashi,
      };
}
