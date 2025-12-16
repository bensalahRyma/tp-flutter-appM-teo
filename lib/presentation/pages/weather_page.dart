import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/providers/weather_provider.dart';

import '../widgets/search_bar_widget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/forecast_widget.dart';

import '../theme/app_theme.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            return RefreshIndicator(
              onRefresh: () => weatherProvider.refresh(),
              color: AppTheme.primaryBlue,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Titre de l'app
                    _buildAppTitle().animate().fadeIn(duration: 300.ms),

                    const SizedBox(height: 20),

                    // Barre de recherche
                    SearchBarWidget(
                      onSearch: (city) {
                        weatherProvider.searchWeather(city);
                      },
                      isLoading: weatherProvider.isLoading,
                    ),

                    const SizedBox(height: 20),

                    // Contenu principal
                    _buildContent(context, weatherProvider),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppTheme.skyGradient,
              borderRadius: BorderRadius.circular(15),
              boxShadow: AppTheme.softShadow,
            ),
            child: const Icon(
              FontAwesomeIcons.cloudSun,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Météo App',
            style: AppTheme.headingSmall.copyWith(
              fontSize: 28,
              color: AppTheme.darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WeatherProvider provider) {
    // État initial
    if (provider.status == WeatherStatus.initial) {
      return _buildInitialState();
    }

    // État de chargement
    if (provider.isLoading) {
      return _buildLoadingState();
    }

    // État d'erreur
    if (provider.hasError) {
      return _buildErrorState(provider.errorMessage ?? 'Une erreur est survenue');
    }

    // État avec données
    if (provider.hasData && provider.currentWeather != null) {
      return Column(
        children: [
          // Widget météo actuelle
          CurrentWeatherWidget(weather: provider.currentWeather!),
          const SizedBox(height: 20),
          // Widget prévisions
          if (provider.forecasts.isNotEmpty)
            ForecastWidget(forecasts: provider.forecasts),
          const SizedBox(height: 40),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildInitialState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: AppTheme.skyGradient,
              shape: BoxShape.circle,
              boxShadow: AppTheme.cardShadow,
            ),
            child: const Icon(
              FontAwesomeIcons.magnifyingGlassLocation,
              size: 80,
              color: Colors.white,
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 2000.ms, color: Colors.white.withAlpha(77)),

          const SizedBox(height: 40),

          Text(
            'Recherchez une ville',
            style: AppTheme.headingSmall.copyWith(fontSize: 24),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 12),

          Text(
            'Entrez le nom d\'une ville pour voir\nla météo actuelle et les prévisions',
            textAlign: TextAlign.center,
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.grey[600],
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: AppTheme.primaryBlue,
            strokeWidth: 3,
          )
              .animate(onPlay: (controller) => controller.repeat())
              .rotate(duration: 1000.ms),

          const SizedBox(height: 24),

          Text(
            'Chargement...',
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.grey[600],
            ),
          ).animate().fadeIn(),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              FontAwesomeIcons.triangleExclamation,
              size: 48,
              color: Colors.red[700],
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),

          const SizedBox(height: 24),

          Text(
            'Oups !',
            style: AppTheme.headingSmall.copyWith(
              color: Colors.red[700],
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.red[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }
}
