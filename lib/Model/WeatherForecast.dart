class WeatherForecast {
  late int timestamp;
  late double temperature;
  late String weatherDescription;
  late String icon;
  late String date;

  WeatherForecast(
      {required this.timestamp,
        required this.temperature,
        required this.weatherDescription,
        required this.icon,
        required this.date
      });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      timestamp: json['dt'],
      temperature: json['main']['temp'].toDouble() - 273.15,
      weatherDescription: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      date: json['dt_txt']
    );
  }
}