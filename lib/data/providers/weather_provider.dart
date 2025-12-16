import 'package:flutter/foundation.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../repositories/weather_repository.dart';

enum WeatherStatus {
  initial,
  loading,
  success,
  error,
}

class WeatherProvider with ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  WeatherStatus _status = WeatherStatus.initial;
  WeatherModel? _currentWeather;
  List<ForecastModel> _forecasts = [];
  String? _errorMessage;
  String _lastSearchedCity = '';

  // Getters
  WeatherStatus get status => _status;
  WeatherModel? get currentWeather => _currentWeather;
  List<ForecastModel> get forecasts => _forecasts;
  String? get errorMessage => _errorMessage;
  String get lastSearchedCity => _lastSearchedCity;

  bool get isLoading => _status == WeatherStatus.loading;
  bool get hasData => _status == WeatherStatus.success && _currentWeather != null;
  bool get hasError => _status == WeatherStatus.error;

  /// Recherche la météo pour une ville
  Future<void> searchWeather(String cityName) async {
    if (cityName.trim().isEmpty) {
      _status = WeatherStatus.error;
      _errorMessage = 'Veuillez entrer un nom de ville';
      notifyListeners();
      return;
    }

    _status = WeatherStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      // Récupère la météo actuelle et les prévisions en parallèle
      final results = await Future.wait([
        _repository.getCurrentWeather(cityName),
        _repository.getForecast(cityName),
      ]);

      _currentWeather = results[0] as WeatherModel;
      _forecasts = results[1] as List<ForecastModel>;
      _lastSearchedCity = cityName;
      _status = WeatherStatus.success;
      _errorMessage = null;
    } catch (e) {
      _status = WeatherStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _currentWeather = null;
      _forecasts = [];
    }

    notifyListeners();
  }

  /// Rafraîchit les données pour la dernière ville recherchée
  Future<void> refresh() async {
    if (_lastSearchedCity.isNotEmpty) {
      await searchWeather(_lastSearchedCity);
    }
  }

  /// Réinitialise l'état
  void reset() {
    _status = WeatherStatus.initial;
    _currentWeather = null;
    _forecasts = [];
    _errorMessage = null;
    _lastSearchedCity = '';
    notifyListeners();
  }
}