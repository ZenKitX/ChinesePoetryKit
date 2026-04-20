// ignore_for_file: avoid_print

/// Benchmark tests for ChinesePoetryKit.
///
/// Run with: dart run benchmark/poetry_benchmark.dart
library;

import 'package:chinese_poetry_kit/chinese_poetry_kit.dart';

void main() {
  print('=== ChinesePoetryKit Performance Benchmark ===\n');

  // Warm up
  print('Warming up...');
  for (int i = 0; i < 100; i++) {
    PoetryService.getRandomPoem();
  }
  print('Warm up complete.\n');

  // Run benchmarks
  benchmarkGetRandomPoem();
  benchmarkGetPoemByCondition();
  benchmarkSearch();
  benchmarkGetAllPoems();
  benchmarkPoemCreation();

  print('\n=== Benchmark Complete ===');
}

void benchmarkGetRandomPoem() {
  print('--- Get Random Poem Benchmark ---');

  final stopwatch = Stopwatch()..start();
  const iterations = 10000;

  for (int i = 0; i < iterations; i++) {
    PoetryService.getRandomPoem();
  }

  stopwatch.stop();
  final avgTime = stopwatch.elapsedMicroseconds / iterations;
  print(
    '  getRandomPoem: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)',
  );
  print('');
}

void benchmarkGetPoemByCondition() {
  print('--- Get Poem by Condition Benchmark ---');

  final conditions = [
    ('weather', 'Rain'),
    ('weather', 'Snow'),
    ('weather', 'Sunny'),
    ('season', 'Spring'),
    ('season', 'Summer'),
    ('season', 'Autumn'),
    ('season', 'Winter'),
    ('solarTerm', '立春'),
    ('solarTerm', '清明'),
    ('solarTerm', '大雪'),
  ];

  final stopwatch = Stopwatch()..start();
  const iterations = 10000;

  for (int i = 0; i < iterations; i++) {
    for (final (type, value) in conditions) {
      switch (type) {
        case 'weather':
          PoetryService.getPoemByWeather(value);
        case 'season':
          PoetryService.getPoemBySeason(value);
        case 'solarTerm':
          PoetryService.getPoemBySolarTerm(value);
      }
    }
  }

  stopwatch.stop();
  final avgTime = stopwatch.elapsedMicroseconds / (iterations * conditions.length);
  print(
    '  getPoemByCondition: ${avgTime.toStringAsFixed(2)} μs/op (${iterations * conditions.length} ops)',
  );
  print('');
}

void benchmarkSearch() {
  print('--- Search Benchmark ---');

  final keywords = ['春', '雨', '雪', '杜甫', '李白'];

  final stopwatch = Stopwatch()..start();
  const iterations = 10000;

  for (int i = 0; i < iterations; i++) {
    for (final keyword in keywords) {
      PoetryService.search(keyword);
    }
  }

  stopwatch.stop();
  final avgTime = stopwatch.elapsedMicroseconds / (iterations * keywords.length);
  print(
    '  search: ${avgTime.toStringAsFixed(2)} μs/op (${iterations * keywords.length} ops)',
  );
  print('');
}

void benchmarkGetAllPoems() {
  print('--- Get All Poems Benchmark ---');

  final stopwatch = Stopwatch()..start();
  const iterations = 10000;

  for (int i = 0; i < iterations; i++) {
    PoetryService.allPoems;
  }

  stopwatch.stop();
  final avgTime = stopwatch.elapsedMicroseconds / iterations;
  print(
    '  allPoems: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)',
  );
  print('');
}

void benchmarkPoemCreation() {
  print('--- Poem Creation Benchmark ---');

  final stopwatch = Stopwatch()..start();
  const iterations = 10000;

  for (int i = 0; i < iterations; i++) {
    Poem(
      title: 'Test Poem',
      author: 'Test Author',
      dynasty: '唐',
      content: 'Test content with some meaningful text.',
      tags: 'Test,Tag',
    );
  }

  stopwatch.stop();
  final avgTime = stopwatch.elapsedMicroseconds / iterations;
  print(
    '  Poem(): ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)',
  );
  print('');
}
