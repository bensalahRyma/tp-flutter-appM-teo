import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/models/weather_model.dart';
import '../../presentation/theme/app_theme.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherModel weather;

  const CurrentWeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: AppTheme.skyGradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Text(
            weather.cityName,
            style: AppTheme.headingSmall.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            weather.description,
            style: AppTheme.bodyMedium.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(FontAwesomeIcons.temperatureHalf, color: Colors.white, size: 60),
              const SizedBox(width: 20),
              Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: AppTheme.headingLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
