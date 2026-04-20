import 'package:flutter_test/flutter_test.dart';
import 'package:chinese_poetry_kit/chinese_poetry_kit.dart';

void main() {
  group('Poem', () {
    test('should create poem with all fields', () {
      final poem = Poem(
        title: '春晓',
        author: '孟浩然',
        dynasty: '唐',
        content: '春眠不觉晓，处处闻啼鸟。夜来风雨声，花落知多少。',
        tags: '春,天气,雨',
      );
      expect(poem.title, '春晓');
      expect(poem.author, '孟浩然');
      expect(poem.dynasty, '唐');
      expect(poem.content.isNotEmpty, isTrue);
      expect(poem.tags?.contains('春'), isTrue);
    });

    test('should create poem without tags', () {
      final poem = Poem(
        title: '静夜思',
        author: '李白',
        dynasty: '唐',
        content: '床前明月光，疑是地上霜。举头望明月，低头思故乡。',
      );
      expect(poem.tags, isNull);
    });
  });

  group('PoetryDatabase', () {
    test('should return non-empty list of poems', () {
      final poems = PoetryDatabase.allPoems;
      expect(poems, isNotEmpty);
    });

    test('should filter poems by tag', () {
      final rainPoems = PoetryDatabase.getPoemsByTag('雨');
      expect(rainPoems, isNotEmpty);
      expect(rainPoems.every((p) => p.tags?.contains('雨') ?? false), isTrue);
    });

    test('should return empty list for non-existent tag', () {
      final poems = PoetryDatabase.getPoemsByTag('不存在的标签');
      expect(poems, isEmpty);
    });

    test('should return poems by dynasty', () {
      final tangPoems = PoetryDatabase.getPoemsByDynasty('唐');
      expect(tangPoems, isNotEmpty);
      expect(tangPoems.every((p) => p.dynasty == '唐'), isTrue);
    });

    test('should search poems by keyword', () {
      final results = PoetryDatabase.searchPoems('春');
      expect(results, isNotEmpty);
      expect(results.every((p) =>
        p.title.contains('春') ||
        p.content.contains('春')
      ), isTrue);
    });

    test('should return poem by exact title', () {
      final poem = PoetryDatabase.getPoemByTitle('春晓');
      expect(poem, isNotNull);
      expect(poem!.title, '春晓');
    });

    test('should return null for non-existent title', () {
      final poem = PoetryDatabase.getPoemByTitle('不存在的诗');
      expect(poem, isNull);
    });

    test('should get available dynasties', () {
      final dynasties = PoetryDatabase.availableDynasties;
      expect(dynasties, isNotEmpty);
      expect(dynasties.contains('唐'), isTrue);
      expect(dynasties.contains('宋'), isTrue);
    });

    test('should get available tags', () {
      final tags = PoetryDatabase.availableTags;
      expect(tags, isNotEmpty);
      expect(tags.contains('春'), isTrue);
      expect(tags.contains('雨'), isTrue);
    });
  });

  group('PoetryService', () {
    test('should return random poem', () {
      final poem = PoetryService.getRandomPoem();
      expect(poem, isNotNull);
      expect(poem.content.isNotEmpty, isTrue);
    });

    test('should return poem matching weather condition', () {
      final poem = PoetryService.getPoem(
        weatherCondition: 'Rain',
        solarTerm: '立春',
        season: 'Spring',
      );
      // Solar term has highest priority
      expect(poem.title.contains('立春'), isTrue);
    });

    test('should return poem by weather only', () {
      final poem = PoetryService.getPoemByWeather('Rain');
      expect(poem, isNotNull);
    });

    test('should return poem by solar term only', () {
      final poem = PoetryService.getPoemBySolarTerm('清明');
      expect(poem, isNotNull);
      expect(poem.title.contains('清明'), isTrue);
    });

    test('should return poem by season only', () {
      final poem = PoetryService.getPoemBySeason('春');
      expect(poem, isNotNull);
    });

    test('should return random poem when no conditions provided', () {
      final poem = PoetryService.getPoem();
      expect(poem, isNotNull);
    });

    test('should search poems by keyword', () {
      final results = PoetryService.search('杜甫');
      expect(results, isNotEmpty);
      expect(results.every((p) => p.author == '杜甫'), isTrue);
    });

    test('should get all poems', () {
      final poems = PoetryService.allPoems;
      expect(poems, isNotEmpty);
    });

    test('should get poem by title', () {
      final poem = PoetryService.getPoemByTitle('静夜思');
      expect(poem, isNotNull);
      expect(poem!.author, '李白');
    });

    test('should get poems by dynasty', () {
      final tangPoems = PoetryService.getPoemsByDynasty('唐');
      expect(tangPoems, isNotEmpty);
      expect(tangPoems.every((p) => p.dynasty == '唐'), isTrue);
    });

    test('should get poems by tag', () {
      final springPoems = PoetryService.getPoemsByTag('春');
      expect(springPoems, isNotEmpty);
    });

    test('should get available tags', () {
      final tags = PoetryService.availableTags;
      expect(tags, isNotEmpty);
    });

    test('should get available dynasties', () {
      final dynasties = PoetryService.availableDynasties;
      expect(dynasties, isNotEmpty);
    });
  });
}
