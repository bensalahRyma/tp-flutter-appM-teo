import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../data/models/forecast_model.dart';
import '../theme/app_theme.dart';

class ForecastWidget extends StatelessWidget {
  final List<ForecastModel> forecasts;

  const ForecastWidget({
    Key? key,
    required this.forecasts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 16),
            child: Text(
              'Prévisions',
              style: AppTheme.headingSmall,
            ),
          ).animate().fadeIn(delay: 500.ms),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: forecasts.length,
            itemBuilder: (context, index) {
              return _buildForecastCard(forecasts[index], index)
                  .animate()
                  .fadeIn(delay: (600 + (index * 100)).ms)
                  .slideX(
                begin: 0.2,
                delay: (600 + (index * 100)).ms,
                curve: Curves.easeOut,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForecastCard(ForecastModel forecast, int index) {
    final dayFormat = DateFormat('EEEE', 'fr_FR');
    final dateFormat = DateFormat('d MMM', 'fr_FR');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.softShadow,
      ),
      child: Row(
        children: [
          // Icône météo
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
              forecast.getIconUrl(),
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  FontAwesomeIcons.cloud,
                  color: AppTheme.primaryBlue,
                  size: 30,
                );
              },
            ),
          ),

          const SizedBox(width: 16),

          // Jour et date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayFormat.format(forecast.dateTime),
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateFormat.format(forecast.dateTime),
                  style: AppTheme.caption,
                ),
                const SizedBox(height: 4),
                Text(
                  forecast.description,
                  style: AppTheme.caption.copyWith(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Températures
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.temperatureHigh,
                    size: 14,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${forecast.tempMax.round()}°',
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.temperatureLow,
                    size: 14,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${forecast.tempMin.round()}°',
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(width: 12),

          // Détails supplémentaires
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.droplet,
                      size: 12,
                      color: AppTheme.primaryBlue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${forecast.humidity}%',
                      style: AppTheme.caption.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}