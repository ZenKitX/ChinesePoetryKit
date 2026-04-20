import 'dart:math';
import '../models/poem_model.dart';

/// Chinese poetry database
///
/// Contains a collection of classical Chinese poems organized by:
/// - Weather conditions (rain, snow, sunny, cloudy, foggy, windy)
/// - Solar terms (24 节气)
/// - Seasons (spring, summer, autumn, winter)
/// - Default/general poems
class PoetryDatabase {
  // Random number generator for uniform distribution
  static final Random _random = Random();

  // Lazy-loaded poem lists
  static List<Poem>? _rainPoems;
  static List<Poem>? _snowPoems;
  static List<Poem>? _sunnyPoems;
  static List<Poem>? _cloudyPoems;
  static List<Poem>? _foggyPoems;
  static List<Poem>? _windyPoems;
  static List<Poem>? _defaultPoems;

  /// Get poem by weather condition
  static Poem getPoemByWeather(String weatherCondition) {
    final condition = weatherCondition.toLowerCase();

    // Rain (雨)
    if (condition.contains('雨') || condition.contains('rain') || condition.contains('shower') || condition.contains('drizzle')) {
      final poems = _rainPoems ??= _loadRainPoems();
      return poems[_random.nextInt(poems.length)];
    }

    // Snow (雪)
    if (condition.contains('雪') || condition.contains('snow') || condition.contains('blizzard') || condition.contains('sleet')) {
      final poems = _snowPoems ??= _loadSnowPoems();
      return poems[_random.nextInt(poems.length)];
    }

    // Sunny (晴)
    if (condition.contains('晴') || condition.contains('sunny') || condition.contains('clear') || condition.contains('sun')) {
      final poems = _sunnyPoems ??= _loadSunnyPoems();
      return poems[_random.nextInt(poems.length)];
    }

    // Cloudy (云/阴)
    if (condition.contains('云') || condition.contains('cloud') || condition.contains('overcast') || condition.contains('阴')) {
      final poems = _cloudyPoems ??= _loadCloudyPoems();
      return poems[_random.nextInt(poems.length)];
    }

    // Foggy (雾)
    if (condition.contains('雾') || condition.contains('fog') || condition.contains('mist') || condition.contains('haze')) {
      final poems = _foggyPoems ??= _loadFoggyPoems();
      return poems[_random.nextInt(poems.length)];
    }

    // Windy (风)
    if (condition.contains('风') || condition.contains('wind') || condition.contains('breeze') || condition.contains('gale')) {
      final poems = _windyPoems ??= _loadWindyPoems();
      return poems[_random.nextInt(poems.length)];
    }

    // Default
    final poems = _defaultPoems ??= _loadDefaultPoems();
    return poems[_random.nextInt(poems.length)];
  }

  /// Get poem by solar term
  static Poem getPoemBySolarTerm(String solarTerm) {
    final poem = _getSolarTermPoem(solarTerm);
    if (poem != null) {
      return poem;
    }
    // Fallback to default if solar term not found
    final poems = _defaultPoems ??= _loadDefaultPoems();
    return poems[_random.nextInt(poems.length)];
  }

  /// Get poem by season
  static Poem getPoemBySeason(String season) {
    final seasonPoems = _getSeasonPoems(season);
    if (seasonPoems.isNotEmpty) {
      return seasonPoems[_random.nextInt(seasonPoems.length)];
    }
    // Fallback to default
    final poems = _defaultPoems ??= _loadDefaultPoems();
    return poems[_random.nextInt(poems.length)];
  }

  /// Get random poem
  static Poem getRandomPoem() {
    // Collect all poems
    final allPoems = <Poem>[
      ..._loadRainPoems(),
      ..._loadSnowPoems(),
      ..._loadSunnyPoems(),
      ..._loadCloudyPoems(),
      ..._loadFoggyPoems(),
      ..._loadWindyPoems(),
      ..._loadDefaultPoems(),
    ];

    return allPoems[_random.nextInt(allPoems.length)];
  }

  /// Search poems by keyword
  static List<Poem> searchPoems(String keyword) {
    final allPoems = <Poem>[
      ..._loadRainPoems(),
      ..._loadSnowPoems(),
      ..._loadSunnyPoems(),
      ..._loadCloudyPoems(),
      ..._loadFoggyPoems(),
      ..._loadWindyPoems(),
      ..._loadDefaultPoems(),
    ];

    return allPoems.where((poem) => poem.containsKeyword(keyword)).toList();
  }

  /// Get all poems
  static List<Poem> get allPoems {
    return [
      ..._loadRainPoems(),
      ..._loadSnowPoems(),
      ..._loadSunnyPoems(),
      ..._loadCloudyPoems(),
      ..._loadFoggyPoems(),
      ..._loadWindyPoems(),
      ..._loadDefaultPoems(),
    ];
  }

  /// Get poems by tag
  static List<Poem> getPoemsByTag(String tag) {
    return allPoems.where((poem) => poem.tags?.contains(tag) ?? false).toList();
  }

  /// Get poems by dynasty
  static List<Poem> getPoemsByDynasty(String dynasty) {
    return allPoems.where((poem) => poem.dynasty == dynasty).toList();
  }

  /// Get poem by title
  static Poem? getPoemByTitle(String title) {
    for (final poem in allPoems) {
      if (poem.title == title) {
        return poem;
      }
    }
    return null;
  }

  /// Get all available dynasties
  static List<String> get availableDynasties {
    final dynasties = allPoems.map((p) => p.dynasty).toSet().toList();
    dynasties.sort();
    return dynasties;
  }

  /// Get all available tags
  static List<String> get availableTags {
    final tags = <String>{};
    for (final poem in allPoems) {
      if (poem.tags != null) {
        tags.addAll(poem.tags!.split(','));
      }
    }
    return tags.toList()..sort();
  }

  // Private: Load rain poems
  static List<Poem> _loadRainPoems() {
    return [
      Poem(
        title: '春夜喜雨',
        author: '杜甫',
        dynasty: '唐',
        content: '好雨知时节，当春乃发生。随风潜入夜，润物细无声。',
        tags: '雨,春',
      ),
      Poem(
        title: '临安春雨初霁',
        author: '陆游',
        dynasty: '宋',
        content: '小楼一夜听春雨，深巷明朝卖杏花。',
        tags: '雨,春',
      ),
      Poem(
        title: '喜雨',
        author: '杜甫',
        dynasty: '唐',
        content: '好雨知时节，当春乃发生。随风潜入夜，润物细无声。',
        tags: '雨,春',
      ),
      Poem(
        title: '春雨',
        author: '杜甫',
        dynasty: '唐',
        content: '随风潜入夜，润物细无声。',
        tags: '雨,春',
      ),
      Poem(
        title: '雨巷',
        author: '戴望舒',
        dynasty: '现代',
        content: '撑着油纸伞，独自彷徨在悠长、悠长又寂寥的雨巷。',
        tags: '雨,现代',
      ),
    ];
  }

  // Private: Load snow poems
  static List<Poem> _loadSnowPoems() {
    return [
      Poem(
        title: '江雪',
        author: '柳宗元',
        dynasty: '唐',
        content: '千山鸟飞绝，万径人踪灭。孤舟蓑笠翁，独钓寒江雪。',
        tags: '雪,冬',
      ),
      Poem(
        title: '白雪歌送武判官归京',
        author: '岑参',
        dynasty: '唐',
        content: '忽如一夜春风来，千树万树梨花开。',
        tags: '雪,冬',
      ),
      Poem(
        title: '逢雪宿芙蓉山主人',
        author: '刘长卿',
        dynasty: '唐',
        content: '柴门闻犬吠，风雪夜归人。',
        tags: '雪,冬',
      ),
      Poem(
        title: '雪梅',
        author: '卢梅坡',
        dynasty: '宋',
        content: '梅雪争春未肯降，骚人阁笔费评章。',
        tags: '雪,冬',
      ),
      Poem(
        title: '对雪',
        author: '高骈',
        dynasty: '唐',
        content: '六出飞花入户时，坐看青竹变琼枝。',
        tags: '雪,冬',
      ),
    ];
  }

  // Private: Load sunny poems
  static List<Poem> _loadSunnyPoems() {
    return [
      Poem(
        title: '春晓',
        author: '孟浩然',
        dynasty: '唐',
        content: '春眠不觉晓，处处闻啼鸟。夜来风雨声，花落知多少。',
        tags: '晴,春',
      ),
      Poem(
        title: '晴朗',
        author: '白居易',
        dynasty: '唐',
        content: '日出江花红胜火，春来江水绿如蓝。',
        tags: '晴,春',
      ),
      Poem(
        title: '咏鹅',
        author: '骆宾王',
        dynasty: '唐',
        content: '白毛浮绿水，红掌拨清波。',
        tags: '晴,春',
      ),
      Poem(
        title: '绝句',
        author: '杜甫',
        dynasty: '唐',
        content: '两个黄鹂鸣翠柳，一行白鹭上青天。',
        tags: '晴,春',
      ),
      Poem(
        title: '惠崇春江晚景',
        author: '苏轼',
        dynasty: '宋',
        content: '竹外桃花三两枝，春江水暖鸭先知。',
        tags: '晴,春',
      ),
    ];
  }

  // Private: Load cloudy poems
  static List<Poem> _loadCloudyPoems() {
    return [
      Poem(
        title: '登鹳雀楼',
        author: '王之涣',
        dynasty: '唐',
        content: '白日依山尽，黄河入海流。欲穷千里目，更上一层楼。',
        tags: '云,登高',
      ),
      Poem(
        title: '望庐山瀑布',
        author: '李白',
        dynasty: '唐',
        content: '日照香炉生紫烟，遥看瀑布挂前川。飞流直下三千尺，疑是银河落九天。',
        tags: '云,山',
      ),
      Poem(
        title: '早发白帝城',
        author: '李白',
        dynasty: '唐',
        content: '朝辞白帝彩云间，千里江陵一日还。',
        tags: '云,江',
      ),
      Poem(
        title: '黄鹤楼送孟浩然之广陵',
        author: '李白',
        dynasty: '唐',
        content: '故人西辞黄鹤楼，烟花三月下扬州。',
        tags: '云,送别',
      ),
      Poem(
        title: '江城子',
        author: '苏轼',
        dynasty: '宋',
        content: '老夫聊发少年狂，左牵黄，右擎苍。',
        tags: '云,豪情',
      ),
    ];
  }

  // Private: Load foggy poems
  static List<Poem> _loadFoggyPoems() {
    return [
      Poem(
        title: '雾都',
        author: '佚名',
        dynasty: '现代',
        content: '雾锁山头山锁雾，天连水尾水连天。',
        tags: '雾,山水',
      ),
      Poem(
        title: '雾',
        author: '苏轼',
        dynasty: '宋',
        content: '雾失楼台，月迷津渡。',
        tags: '雾,夜',
      ),
      Poem(
        title: '秋夕',
        author: '杜牧',
        dynasty: '唐',
        content: '银烛秋光冷画屏，轻罗小扇扑流萤。',
        tags: '雾,秋',
      ),
      Poem(
        title: '夜泊牛渚怀古',
        author: '李白',
        dynasty: '唐',
        content: '登舟望秋月，空忆谢将军。余亦能高咏，斯人不可闻。',
        tags: '雾,夜,怀古',
      ),
      Poem(
        title: '登金陵凤凰台',
        author: '李白',
        dynasty: '唐',
        content: '总为浮云能蔽日，长安不见使人愁。',
        tags: '雾,怀古',
      ),
    ];
  }

  // Private: Load windy poems
  static List<Poem> _loadWindyPoems() {
    return [
      Poem(
        title: '蝶恋花',
        author: '晏殊',
        dynasty: '宋',
        content: '昨夜西风凋碧树，独上高楼，望尽天涯路。',
        tags: '风,秋',
      ),
      Poem(
        title: '赋得古原草送别',
        author: '白居易',
        dynasty: '唐',
        content: '野火烧不尽，春风吹又生。',
        tags: '风,春',
      ),
      Poem(
        title: '泊船瓜洲',
        author: '王安石',
        dynasty: '宋',
        content: '春风又绿江南岸，明月何时照我还。',
        tags: '风,春,思乡',
      ),
      Poem(
        title: '凉州词',
        author: '王之涣',
        dynasty: '唐',
        content: '羌笛何须怨杨柳，春风不度玉门关。',
        tags: '风,边塞',
      ),
      Poem(
        title: '大风歌',
        author: '刘邦',
        dynasty: '汉',
        content: '大风起兮云飞扬，威加海内兮归故乡。',
        tags: '风,豪情',
      ),
    ];
  }

  // Private: Load default poems
  static List<Poem> _loadDefaultPoems() {
    return [
      Poem(
        title: '昆明竹枝词',
        author: '佚名',
        dynasty: '清',
        content: '天气常如二三月，花枝不断四时春。',
        tags: '春,四季',
      ),
      Poem(
        title: '大林寺桃花',
        author: '白居易',
        dynasty: '唐',
        content: '人间四月芳菲尽，山寺桃花始盛开。',
        tags: '春,山寺',
      ),
      Poem(
        title: '饮酒',
        author: '陶渊明',
        dynasty: '晋',
        content: '采菊东篱下，悠然见南山。',
        tags: '秋,田园',
      ),
      Poem(
        title: '山居秋暝',
        author: '王维',
        dynasty: '唐',
        content: '空山新雨后，天气晚来秋。明月松间照，清泉石上流。',
        tags: '秋,山水',
      ),
      Poem(
        title: '静夜思',
        author: '李白',
        dynasty: '唐',
        content: '床前明月光，疑是地上霜。举头望明月，低头思故乡。',
        tags: '思乡,月',
      ),
    ];
  }

  // Private: Get solar term poem
  static Poem? _getSolarTermPoem(String solarTerm) {
    final solarTermPoems = {
      '立春': Poem(
        title: '立春偶成',
        author: '张栻',
        dynasty: '宋',
        content: '律回岁晚冰霜少，春到人间草木知。',
        tags: '立春,春',
      ),
      '雨水': Poem(
        title: '早春呈水部张十八员外',
        author: '韩愈',
        dynasty: '唐',
        content: '天街小雨润如酥，草色遥看近却无。',
        tags: '雨水,春',
      ),
      '惊蛰': Poem(
        title: '观田家',
        author: '韦应物',
        dynasty: '唐',
        content: '微雨众卉新，一雷惊蛰始。',
        tags: '惊蛰,春',
      ),
      '春分': Poem(
        title: '春分',
        author: '徐铉',
        dynasty: '宋',
        content: '春分雨脚落声微，柳岸斜风带客归。',
        tags: '春分,春',
      ),
      '清明': Poem(
        title: '清明',
        author: '杜牧',
        dynasty: '唐',
        content: '清明时节雨纷纷，路上行人欲断魂。',
        tags: '清明,春',
      ),
      '谷雨': Poem(
        title: '谷雨',
        author: '佚名',
        dynasty: '唐',
        content: '谷雨春光晓，山川黛色青。',
        tags: '谷雨,春',
      ),
      '立夏': Poem(
        title: '山亭夏日',
        author: '高骈',
        dynasty: '唐',
        content: '绿树阴浓夏日长，楼台倒影入池塘。',
        tags: '立夏,夏',
      ),
      '小满': Poem(
        title: '小满',
        author: '欧阳修',
        dynasty: '宋',
        content: '小满天逐热，温风沐麦圆。',
        tags: '小满,夏',
      ),
      '芒种': Poem(
        title: '时雨',
        author: '陆游',
        dynasty: '宋',
        content: '时雨及芒种，四野皆插秧。',
        tags: '芒种,夏',
      ),
      '夏至': Poem(
        title: '夏至避暑北池',
        author: '韦应物',
        dynasty: '唐',
        content: '昼晷已云极，宵漏自此长。',
        tags: '夏至,夏',
      ),
      '小暑': Poem(
        title: '小暑六月节',
        author: '元稹',
        dynasty: '唐',
        content: '倏忽温风至，因循小暑来。',
        tags: '小暑,夏',
      ),
      '大暑': Poem(
        title: '大暑',
        author: '曾几',
        dynasty: '宋',
        content: '赤日几时过，清风无处寻。',
        tags: '大暑,夏',
      ),
      '立秋': Poem(
        title: '立秋',
        author: '刘翰',
        dynasty: '宋',
        content: '乳鸦啼散玉屏空，一枕新凉一扇风。',
        tags: '立秋,秋',
      ),
      '处暑': Poem(
        title: '处暑',
        author: '左河水',
        dynasty: '现代',
        content: '一度暑出处暑时，秋风送爽已觉迟。',
        tags: '处暑,秋',
      ),
      '白露': Poem(
        title: '诗经·蒹葭',
        author: '佚名',
        dynasty: '先秦',
        content: '蒹葭苍苍，白露为霜。所谓伊人，在水一方。',
        tags: '白露,秋',
      ),
      '秋分': Poem(
        title: '秋分',
        author: '佚名',
        dynasty: '唐',
        content: '暑退秋澄转爽凉，日光夜色两均长。',
        tags: '秋分,秋',
      ),
      '寒露': Poem(
        title: '八月十九日试院梦冲卿',
        author: '王安石',
        dynasty: '宋',
        content: '空庭得秋长漫漫，寒露入暮愁衣单。',
        tags: '寒露,秋',
      ),
      '霜降': Poem(
        title: '南乡子·霜降水痕收',
        author: '苏轼',
        dynasty: '宋',
        content: '霜降水痕收，浅碧鳞鳞露远洲。',
        tags: '霜降,秋',
      ),
      '立冬': Poem(
        title: '立冬',
        author: '陆游',
        dynasty: '宋',
        content: '细雨生寒未有霜，庭前木叶半青黄。',
        tags: '立冬,冬',
      ),
      '小雪': Poem(
        title: '小雪',
        author: '李白',
        dynasty: '唐',
        content: '久雨重阳后，清寒小雪前。',
        tags: '小雪,冬',
      ),
      '大雪': Poem(
        title: '对雪',
        author: '杜甫',
        dynasty: '唐',
        content: '大雪纷纷何所有，明年春色倍还人。',
        tags: '大雪,冬',
      ),
      '冬至': Poem(
        title: '小至',
        author: '杜甫',
        dynasty: '唐',
        content: '天时人事日相催，冬至阳生春又来。',
        tags: '冬至,冬',
      ),
      '小寒': Poem(
        title: '小寒',
        author: '元稹',
        dynasty: '唐',
        content: '小寒连大吕，欢鹊垒新巢。',
        tags: '小寒,冬',
      ),
      '大寒': Poem(
        title: '大寒吟',
        author: '邵雍',
        dynasty: '宋',
        content: '蜡树银山炫皎光，朔风独啸静三江。',
        tags: '大寒,冬',
      ),
    };

    return solarTermPoems[solarTerm];
  }

  // Private: Get season poems
  static List<Poem> _getSeasonPoems(String season) {
    switch (season) {
      case '春':
        return [
          ..._loadRainPoems().where((p) => p.tags?.contains('春') ?? false),
          ..._loadSunnyPoems().where((p) => p.tags?.contains('春') ?? false),
          ..._loadWindyPoems().where((p) => p.tags?.contains('春') ?? false),
        ];
      case '夏':
        return [
          ..._loadSunnyPoems().where((p) => p.tags?.contains('夏') ?? false),
          ..._loadCloudyPoems().where((p) => p.tags?.contains('夏') ?? false),
        ];
      case '秋':
        return [
          ..._loadCloudyPoems().where((p) => p.tags?.contains('秋') ?? false),
          ..._loadFoggyPoems().where((p) => p.tags?.contains('秋') ?? false),
          ..._loadWindyPoems().where((p) => p.tags?.contains('秋') ?? false),
        ];
      case '冬':
        return [
          ..._loadSnowPoems().where((p) => p.tags?.contains('冬') ?? false),
          ..._loadFoggyPoems().where((p) => p.tags?.contains('冬') ?? false),
        ];
      default:
        return [];
    }
  }
}
