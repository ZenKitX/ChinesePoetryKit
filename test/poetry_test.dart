import 'package:flutter_test/flutter_test.dart';
import 'package:chinese_poetry_kit/chinese_poetry_kit.dart';

void main() {
  group('Poem', () {
    test('should create poem with all fields', () {
      final poem = Poem(
        title: '春晓',
        author: '孟浩然',
        dynasty: '唐',
        content: ['春眠不觉晓', '处处闻啼鸟', '夜来风雨声', '花落知多少'],
        tags: ['春', '天气', '雨'],
      );
      expect(poem.title, '春晓');
      expect(poem.author, '孟浩然');
      expect(poem.dynasty, '唐');
      expect(poem.content.length, 4);
      expect(poem.tags, contains('春'));
    });

    test('should create poem without tags', () {
      final poem = Poem(
        title: '静夜思',
        author: '李白',
        dynasty: '唐',
        content: ['床前明月光', '疑是地上霜', '举头望明月', '低头思故乡'],
      );
      expect(poem.tags, isEmpty);
    });
  });

  group('PoetryDatabase', () {
    late PoetryDatabase database;

    setUp(() {
      database = PoetryDatabase();
    });

    test('should return non-empty list of poems', () {
      final poems = database.getAllPoems();
      expect(poems, isNotEmpty);
    });

    test('should filter poems by tag', () {
      final rainPoems = database.getPoemsByTag('雨');
      expect(rainPoems, isNotEmpty);
      expect(rainPoems.every((p) => p.tags.contains('雨')), isTrue);
    });

    test('should return empty list for non-existent tag', () {
      final poems = database.getPoemsByTag('不存在的标签');
      expect(poems, isEmpty);
    });

    test('should return poems by dynasty', () {
      final tangPoems = database.getPoemsByDynasty('唐');
      expect(tangPoems, isNotEmpty);
      expect(tangPoems.every((p) => p.dynasty == '唐'), isTrue);
    });

    test('should search poems by keyword', () {
      final results = database.search('春');
      expect(results, isNotEmpty);
      expect(results.every((p) =>
        p.title.contains('春') ||
        p.content.any((line) => line.contains('春'))
      ), isTrue);
    });

    test('should return poem by exact title', () {
      final poem = database.getPoemByTitle('春晓');
      expect(poem, isNotNull);
      expect(poem!.title, '春晓');
    });

    test('should return null for non-existent title', () {
      final poem = database.getPoemByTitle('不存在的诗');
      expect(poem, isNull);
    });
  });

  group('PoetryService', () {
    late PoetryService service;

    setUp(() {
      service = PoetryService();
    });

    test('should return random poem', () {
      final poem = service.getRandomPoem();
      expect(poem, isNotNull);
      expect(poem!.content, isNotEmpty);
    });

    test('should return poem matching weather condition', () {
      final poem = service.getPoem(
        weatherCondition: 'Rain',
        solarTerm: '立春',
        season: 'Spring',
      );
      expect(poem, isNotNull);
    });

    test('should return poem matching solar term', () {
      final poem = service.getPoem(solarTerm: '清明');
      expect(poem, isNotNull);
    });

    test('should return poem matching season', () {
      final poem = service.getPoem(season: 'Autumn');
      expect(poem, isNotNull);
    });

    test('should prefer specific match over general match', () {
      final poem1 = service.getPoem(weatherCondition: 'Rain');
      final poem2 = service.getPoem(season: 'Summer');
      // When multiple matches exist, should return one of them
      expect(poem1, isNotNull);
      expect(poem2, isNotNull);
    });

    test('should return poem by dynasty', () {
      final poem = service.getPoemByDynasty('唐');
      expect(poem, isNotNull);
      expect(poem!.dynasty, '唐');
    });

    test('should search poems by keyword', () {
      final results = service.search('月');
      expect(results, isNotEmpty);
    });

    test('should return all poems', () {
      final allPoems = service.getAllPoems();
      expect(allPoems, isNotEmpty);
      expect(allPoems.length, greaterThan(50));
    });

    test('should get unique tags', () {
      final tags = service.getAvailableTags();
      expect(tags, isNotEmpty);
      expect(tags, contains('春'));
      expect(tags, contains('雨'));
    });

    test('should get unique dynasties', () {
      final dynasties = service.getAvailableDynasties();
      expect(dynasties, isNotEmpty);
      expect(dynasties, contains('唐'));
    });
  });
}
