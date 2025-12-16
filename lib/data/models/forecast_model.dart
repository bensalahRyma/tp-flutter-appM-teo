class ForecastModel {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;
  final int humidity;
  final double precipitation;

  ForecastModel({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.precipitation,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] as num).toDouble() - 273.15,
      tempMin: (json['main']['temp_min'] as num).toDouble() - 273.15,
      tempMax: (json['main']['temp_max'] as num).toDouble() - 273.15,
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      precipitation: json['rain'] != null ? (json['rain']['3h'] as num?)?.toDouble() ?? 0.0 : 0.0,
    );
  }

  String getIconUrl() {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }
}