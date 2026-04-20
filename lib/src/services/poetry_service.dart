import '../database/poetry_database.dart';
import '../models/poem_model.dart';

/// Poetry service for intelligent poem matching
class PoetryService {
  PoetryService._();

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
  static Poem getPoem({
    String? weatherCondition,
    String? solarTerm,
    String? season,
  }) {
    // Priority 1: Solar term
    if (solarTerm != null && solarTerm.isNotEmpty) {
      return PoetryDatabase.getPoemBySolarTerm(solarTerm);
    }

    // Priority 2: Weather condition
    if (weatherCondition != null && weatherCondition.isNotEmpty) {
      return PoetryDatabase.getPoemByWeather(weatherCondition);
    }

    // Priority 3: Season
    if (season != null && season.isNotEmpty) {
      return PoetryDatabase.getPoemBySeason(season);
    }

    // Priority 4: Default
    return PoetryDatabase.getRandomPoem();
  }

  /// Get poem by weather condition
  static Poem getPoemByWeather(String weatherCondition) {
    return PoetryDatabase.getPoemByWeather(weatherCondition);
  }

  /// Get poem by solar term
  static Poem getPoemBySolarTerm(String solarTerm) {
    return PoetryDatabase.getPoemBySolarTerm(solarTerm);
  }

  /// Get poem by season
  static Poem getPoemBySeason(String season) {
    return PoetryDatabase.getPoemBySeason(season);
  }

  /// Get poem by dynasty
  static List<Poem> getPoemsByDynasty(String dynasty) {
    return PoetryDatabase.getPoemsByDynasty(dynasty);
  }

  /// Get random poem
  static Poem getRandomPoem() {
    return PoetryDatabase.getRandomPoem();
  }

  /// Search poems by keyword
  static List<Poem> search(String keyword) {
    return PoetryDatabase.searchPoems(keyword);
  }

  /// Get all poems
  static List<Poem> get allPoems => PoetryDatabase.allPoems;

  /// Get poem by title
  static Poem? getPoemByTitle(String title) {
    return PoetryDatabase.getPoemByTitle(title);
  }

  /// Get poems by tag
  static List<Poem> getPoemsByTag(String tag) {
    return PoetryDatabase.getPoemsByTag(tag);
  }

  /// Get available tags
  static List<String> get availableTags => PoetryDatabase.availableTags;

  /// Get available dynasties
  static List<String> get availableDynasties => PoetryDatabase.availableDynasties;
}
