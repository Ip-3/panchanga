class ShubaAshubaModel {
  String date;
  String shubhaAshubha;

  ShubaAshubaModel({
    required this.date,
    required this.shubhaAshubha,
  });

  factory ShubaAshubaModel.fromJson(Map<String, dynamic> json) {
    return ShubaAshubaModel(date: '', shubhaAshubha: '');
  }
  Map toJson() => {
        "date": date,
        "shubhaAshubha": shubhaAshubha,
      };
}
