import 'dart:math';

/// ChinesePoetryKit - A Chinese poetry package for Flutter apps
///
/// This package provides:
/// - A database of classical Chinese poems
/// - Smart matching by weather, solar term, and season
/// - Random poem selection with uniform distribution
/// - Search functionality
///
/// Usage:
/// ```dart
/// final poem = PoetryDatabase.getPoemByWeather('rain');
/// print('${poem.title} - ${poem.author}');
/// print(poem.content);
/// ```
library chinese_poetry_kit;

export 'src/database/poetry_database.dart';
export 'src/models/poem_model.dart';
export 'src/services/poetry_service.dart';
