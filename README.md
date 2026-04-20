# ChinesePoetryKit

A Chinese poetry package for Flutter apps. Provides a database of classical Chinese poems with smart matching.

## Features

- ✅ 60+ classical Chinese poems
- ✅ Smart matching by weather, solar term, and season
- ✅ Uniform random distribution (fixed algorithm issue)
- ✅ Search functionality
- ✅ No external dependencies

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  chinese_poetry_kit:
    git:
      url: https://github.com/ZenKitX/ChinesePoetryKit.git
      ref: main
```

## Usage

### Basic Usage

```dart
import 'package:chinese_poetry_kit/chinese_poetry_kit.dart';

void main() {
  // Get poem by weather
  final poem = PoetryDatabase.getPoemByWeather('rain');
  print('${poem.title} - ${poem.author}');
  print(poem.content);
  print(poem.displayText);
}
```

### Using PoetryService

```dart
final poetryService = PoetryService(
  database: PoetryDatabase(),
);

// Intelligent matching (priority: solar term > weather > season > default)
final poem = poetryService.getPoem(
  weatherCondition: 'rain',
  solarTerm: '立春',
  season: '春',
);
```

### Get Poem by Category

```dart
// By weather
final rainPoem = PoetryDatabase.getPoemByWeather('rain');
final snowPoem = PoetryDatabase.getPoemByWeather('snow');

// By solar term
final springPoem = PoetryDatabase.getPoemBySolarTerm('立春');

// By season
final springSeasonPoem = PoetryDatabase.getPoemBySeason('春');

// Random
final randomPoem = PoetryDatabase.getRandomPoem();
```

### Search Poems

```dart
final results = PoetryDatabase.searchPoems('春');
for (final poem in results) {
  print(poem.title);
}
```

## Poem Categories

### Weather Conditions
- Rain (雨)
- Snow (雪)
- Sunny (晴)
- Cloudy (云)
- Foggy (雾)
- Windy (风)

### Solar Terms (24 节气)
- 立春, 雨水, 惊蛰, 春分, 清明, 谷雨
- 立夏, 小满, 芒种, 夏至, 小暑, 大暑
- 立秋, 处暑, 白露, 秋分, 寒露, 霜降
- 立冬, 小雪, 大雪, 冬至, 小寒, 大寒

### Seasons
- Spring (春)
- Summer (夏)
- Autumn (秋)
- Winter (冬)

## Poem Model

```dart
class Poem {
  final String title;      // Title
  final String author;     // Author
  final String dynasty;    // Dynasty
  final String content;    // Content
  final String? tags;      // Tags (optional)

  String get displayText;  // Formatted display text
}
```

## Algorithm Improvement

### Fixed: Random Distribution

**Before**: Used `DateTime.now().millisecond` which caused uneven distribution
```dart
return _poems[DateTime.now().millisecond % _poems.length];
```

**After**: Uses `Random` class for uniform distribution
```dart
static final Random _random = Random();
return _poems[_random.nextInt(_poems.length)];
```

**Result**: All poems now have equal probability of being selected.

### Lazy Loading

Poem lists are loaded on-demand to reduce memory footprint:
```dart
static List<Poem>? _rainPoems;

if (condition.contains('雨')) {
  final poems = _rainPoems ??= _loadRainPoems();  // Load only when needed
  return poems[_random.nextInt(poems.length)];
}
```

## Example Output

```dart
final poem = PoetryDatabase.getPoemByWeather('rain');

print(poem.title);      // 春夜喜雨
print(poem.author);     // 杜甫
print(poem.dynasty);    // 唐
print(poem.content);    // 好雨知时节，当春乃发生。随风潜入夜，润物细无声。
print(poem.displayText);
// 好雨知时节，当春乃发生。随风潜入夜，润物细无声。
//
// —— 杜甫《春夜喜雨》
```

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to:
- Add more poems
- Improve the matching algorithm
- Fix bugs
- Improve documentation
