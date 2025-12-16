import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherRepository {
  static const String _apiKey = 'a14d91774e698e0f0fc796ba652ef6a6';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final url = Uri.parse('$_baseUrl/weather?q=$cityName&appid=$_apiKey');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return WeatherModel.fromJson(json);
      } else if (response.statusCode == 404) {
        throw Exception('Ville non trouvée');
      } else {
        throw Exception('Erreur lors de la récupération des données: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  Future<List<ForecastModel>> getForecast(String cityName) async {
    try {
      final url = Uri.parse('$_baseUrl/forecast?q=$cityName&appid=$_apiKey');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> forecastList = json['list'];

        Map<String, ForecastModel> dailyForecasts = {};

        for (var item in forecastList) {
          final forecast = ForecastModel.fromJson(item);
          final dateKey = '${forecast.dateTime.year}-${forecast.dateTime.month}-${forecast.dateTime.day}';

          if (!dailyForecasts.containsKey(dateKey) || forecast.dateTime.hour == 12) {
            dailyForecasts[dateKey] = forecast;
          }
        }

        // Retourne les 4 prochains jours
        return dailyForecasts.values.take(4).toList();
      } else if (response.statusCode == 404) {
        throw Exception('Ville non trouvée');
      } else {
        throw Exception('Erreur lors de la récupération des prévisions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}