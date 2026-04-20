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
  final warmupService = PoetryService();
  for (int i = 0; i < 100; i++) {
    warmupService.getRandomPoem();
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

  final service = PoetryService();
  final stopwatch = Stopwatch()..start();
  const iterations = 10000;

  for (int i = 0; i < iterations; i++) {
    service.getRandomPoem();
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

  final service = PoetryService();
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
    ('solarTerm', '秋分'),
  ];

  for (final (type, value) in conditions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 10000;

    for (int i = 0; i < iterations; i++) {
      switch (type) {
        case 'weather':
          service.getPoem(weatherCondition: value);
        case 'season':
          service.getPoem(season: value);
        case 'solarTerm':
          service.getPoem(solarTerm: value);
      }
    }

    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print(
      '  getPoem($type: $value): ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)',
    );
  }
  print('');
}

void benchmarkSearch() {
  print('--- Search Benchmark ---');

  final service = PoetryService();
  final keywords = ['春', '月', '雨', '雪', '花', '山', '水', '风'];

  for (final keyword in keywords) {
    final stopwatch = Stopwatch()..start();
    const iterations = 10000;

    for (int i = 0; i < iterations; i++) {
      service.search(keyword);
    }

    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print(
      '  search("$keyword"): ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)',
    );
  }
  print('');
}

void benchmarkGetAllPoems() {
  print('--- Get All Poems Benchmark ---');

  final service = PoetryService();
  final stopwatch = Stopwatch()..start();
  const iterations = 1000;

  for (int i = 0; i < iterations; i++) {
    service.getAllPoems();
  }

  stopwatch.stop();
  final avgTime = stopwatch.elapsedMicroseconds / iterations;
  print(
    '  getAllPoems: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)',
  );
  print('');
}

void benchmarkPoemCreation() {
  print('--- Poem Creation Benchmark ---');

  const iterations = 100000;

  // Benchmark small poem (4 lines)
  final stopwatch = Stopwatch()..start();

  for (int i = 0; i < iterations; i++) {
    Poem(
      title: 'Test Poem',
      author: 'Test Author',
      dynasty: '唐',
      content: ['第一句', '第二句', '第三句', '第四句'],
      tags: ['春', '雨'],
    );
  }

  stopwatch.stop();
  final avgTime1 = stopwatch.elapsedMicroseconds / iterations;
  print(
    '  Poem (4 lines): ${avgTime1.toStringAsFixed(2)} μs/op ($iterations ops)',
  );

  // Benchmark large poem (8 lines)
  stopwatch.reset();
  stopwatch.start();

  for (int i = 0; i < iterations; i++) {
    Poem(
      title: 'Test Poem',
      author: 'Test Author',
      dynasty: '唐',
      content: [
        '第一句',
        '第二句',
        '第三句',
        '第四句',
        '第五句',
        '第六句',
        '第七句',
        '第八句',
      ],
      tags: ['春', '雨', '夜'],
    );
  }

  stopwatch.stop();
  final avgTime2 = stopwatch.elapsedMicroseconds / iterations;
  print(
    '  Poem (8 lines): ${avgTime2.toStringAsFixed(2)} μs/op ($iterations ops)',
  );

  // Benchmark poem with no tags
  stopwatch.reset();
  stopwatch.start();

  for (int i = 0; i < iterations; i++) {
    Poem(
      title: 'Test Poem',
      author: 'Test Author',
      dynasty: '唐',
      content: ['第一句', '第二句', '第三句', '第四句'],
    );
  }

  stopwatch.stop();
  final avgTime3 = stopwatch.elapsedMicroseconds / iterations;
  print(
    '  Poem (no tags): ${avgTime3.toStringAsFixed(2)} μs/op ($iterations ops)',
  );
  print('');
}
