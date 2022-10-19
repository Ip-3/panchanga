class Day {
  String date;
  String month;
  String year;
  String samvatsara;
  String ayana;
  String rutu;
  String masa;
  String paksha;
  String calendarmark;
  String vasara;
  String nakshatra;
  String masaniyamaka;
  String yoga;
  String karana;
  String sunrise;
  String sunset;
  String shradhatithi;
  String vishesha;
  String tithi;

  Day(
      {required this.date,
      required this.month,
      required this.year,
      required this.samvatsara,
      required this.ayana,
      required this.rutu,
      required this.masa,
      required this.masaniyamaka,
      required this.paksha,
      required this.tithi,
      required this.calendarmark,
      required this.vasara,
      required this.nakshatra,
      required this.yoga,
      required this.karana,
      required this.sunrise,
      required this.sunset,
      required this.shradhatithi,
      required this.vishesha});

  factory Day.fromJson(dynamic json) {
    return Day(
      date: "${json['date']}",
      month: "${json['month']}",
      year: "${json['year']}",
      samvatsara: "${json['samvatsara']}",
      ayana: "${json['ayana']}",
      rutu: "${json['rutu']}",
      masa: "${json['masa']}",
      masaniyamaka: "${json['masaniyamaka']}",
      paksha: "${json['paksha']}",
      tithi: "${json['tithi']}",
      calendarmark: "${json['calendarmark']}",
      vasara: "${json['vasara']}",
      vishesha: "${json['vishesha']}",
      yoga: "${json['yoga']}",
      karana: "${json['karana']}",
      sunrise: "${json['sunrise']}",
      sunset: "${json['sunset']}",
      shradhatithi: "${json['shradhatithi']}",
      nakshatra: "${json['nakshatra']}",
    );
  }

  Map toJson() => {
        "date": date,
        "month": month,
        "year": year,
        "samvatsara": samvatsara,
        "ayana": ayana,
        "rutu": rutu,
        "masa": masa,
        "masaniyamaka": masaniyamaka,
        "paksha": paksha,
        "tithi": tithi,
        "calendarmark": calendarmark,
        "vasara": vasara,
        "nakshatra": nakshatra,
        "yoga": yoga,
        "karana": karana,
        "sunrise": sunrise,
        "sunset": sunset,
        "shradhatithi": shradhatithi,
        "vishesha": vishesha
      };
}
