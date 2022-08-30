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
      {this.date,
      this.month,
      this.year,
      this.samvatsara,
      this.ayana,
      this.rutu,
      this.masa,
      this.masaniyamaka,
      this.paksha,
      this.tithi,
      this.calendarmark,
      this.vasara,
      this.nakshatra,
      this.yoga,
      this.karana,
      this.sunrise,
      this.sunset,
      this.shradhatithi,
      this.vishesha});

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
