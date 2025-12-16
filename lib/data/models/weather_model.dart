class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String description;
  final String icon;
  final int humidity;
  final double precipitation;
  final double windSpeed;
  final int pressure;
  final DateTime dateTime;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.precipitation,
    required this.windSpeed,
    required this.pressure,
    required this.dateTime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble() - 273.15, // Kelvin to Celsius
      feelsLike: (json['main']['feels_like'] as num).toDouble() - 273.15,
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      precipitation: json['rain'] != null ? (json['rain']['1h'] as num?)?.toDouble() ?? 0.0 : 0.0,
      windSpeed: (json['wind']['speed'] as num?)?.toDouble() ?? 0.0,
      pressure: json['main']['pressure'] ?? 0,
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  String getIconUrl() {
    return 'https://openweathermap.org/img/wn/$icon@4x.png';
  }
}