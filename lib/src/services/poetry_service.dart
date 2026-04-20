import '../database/poetry_database.dart';
import '../models/poem_model.dart';

/// Poetry service for intelligent poem matching
class PoetryService {
  final PoetryDatabase database;

  /// Create poetry service
  ///
  /// [database] - Poetry database instance
  PoetryService({required this.database});

  /// Get poem with intelligent matching
  ///
  /// Priority:
  /// 1. Solar term poem (if provided)
  /// 2. Weather poem (if provided)
  /// 3. Season poem (if provided)
  /// 4. Default poem
  ///
  /// [weatherCondition] - Weather condition (e.g., "rain", "snow", "sunny")
  /// [solarTerm] - Solar term (e.g., "立春", "雨水")
  /// [season] - Season (e.g., "春", "夏", "秋", "冬")
  Poem getPoem({
    String? weatherCondition,
    String? solarTerm,
    String? season,
  }) {
    // Priority 1: Solar term
    if (solarTerm != null && solarTerm.isNotEmpty) {
      return database.getPoemBySolarTerm(solarTerm);
    }

    // Priority 2: Weather condition
    if (weatherCondition != null && weatherCondition.isNotEmpty) {
      return database.getPoemByWeather(weatherCondition);
    }

    // Priority 3: Season
    if (season != null && season.isNotEmpty) {
      return database.getPoemBySeason(season);
    }

    // Priority 4: Default
    return database.getRandomPoem();
  }

  /// Get poem by weather condition
  Poem getPoemByWeather(String weatherCondition) {
    return database.getPoemByWeather(weatherCondition);
  }

  /// Get poem by solar term
  Poem getPoemBySolarTerm(String solarTerm) {
    return database.getPoemBySolarTerm(solarTerm);
  }

  /// Get poem by season
  Poem getPoemBySeason(String season) {
    return database.getPoemBySeason(season);
  }

  /// Get random poem
  Poem getRandomPoem() {
    return database.getRandomPoem();
  }

  /// Search poems by keyword
  List<Poem> searchPoems(String keyword) {
    return database.searchPoems(keyword);
  }

  /// Get all poems
  List<Poem> getAllPoems() {
    return database.allPoems;
  }
}
