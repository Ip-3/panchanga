class ShubaAshubaModel {
  String date;
  String month;

  String year;

  String shubhaAshubha;

  ShubaAshubaModel({
    required this.date,
    required this.month,
    required this.year,
    required this.shubhaAshubha,
  });

  factory ShubaAshubaModel.fromJson(Map<String, dynamic> json) {
    return ShubaAshubaModel(date: '', shubhaAshubha: '', month: '', year: '');
  }
  Map toJson() => {
        "date": date,
        "month": month,
        "year": year,
        "shubhaAshubha": shubhaAshubha,
      };
}
