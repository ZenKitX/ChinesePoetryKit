# ChinesePoetryKit 架构设计

本文档描述 ChinesePoetryKit 项目的架构设计原则和实现方案。

## 目录

1. [设计原则](#设计原则)
2. [目录结构](#目录结构)
3. [模块划分](#模块划分)
4. [数据流](#数据流)
5. [匹配算法](#匹配算法)
6. [性能优化](#性能优化)

## 设计原则

### 1. 简单性原则 (Simplicity)

ChinesePoetryKit 提供简单直观的 API，易于理解和使用。

**优势:**

- 快速上手
- 减少学习成本
- 降低出错概率

### 2. 单一职责原则 (Single Responsibility Principle)

每个类只负责一个明确的功能。

**示例:**

- `PoetryService` 只负责诗词查询和匹配
- `PoetryDatabase` 只负责诗词数据存储
- `Poem` 只负责诗词数据模型

### 3. 数据驱动 (Data-Driven)

通过标签和元数据实现智能匹配。

**优势:**

- 灵活的内容管理
- 可扩展的匹配规则
- 易于维护和更新

### 4. 性能优先 (Performance First)

优化常见操作的性能。

**优势:**

- 快速的诗词检索
- 低内存占用
- 高效的匹配算法

## 目录结构

```
lib/
├── chinese_poetry_kit.dart       # 主导出文件
└── src/
    ├── database/
    │   └── poetry_database.dart  # 诗词数据库
    ├── models/
    │   └── poem_model.dart       # 诗词模型
    └── services/
        └── poetry_service.dart   # 诗词服务

test/                              # 测试目录
└── poetry_test.dart

doc/                               # 文档目录
├── API.md
└── ARCHITECTURE.md

.github/workflows/                 # CI/CD 配置
└── dart.yml
```

## 模块划分

### Models（数据模型）

定义数据结构。

#### Poem

**职责:**

- 表示单个诗词
- 包含标题、作者、朝代、内容、标签

**字段:**

```dart
String title        // 标题
String author       // 作者
String dynasty      // 朝代
List<String> content // 内容（每句一句）
List<String> tags   // 标签
```

**标签分类:**

- 天气: 雨、雪、晴、云、雾、风
- 节气: 24 节气名称
- 季节: 春、夏、秋、冬

### Database（数据层）

实现诗词数据存储和查询。

#### PoetryDatabase

**职责:**

- 存储所有诗词数据
- 提供查询接口
- 支持标签和关键词搜索

**主要方法:**

- `getAllPoems()`: 获取所有诗词
- `getPoemsByTag(tag)`: 根据标签获取诗词
- `getPoemsByDynasty(dynasty)`: 根据朝代获取诗词
- `search(keyword)`: 搜索诗词
- `getPoemByTitle(title)`: 根据标题获取诗词

### Services（服务层）

实现业务逻辑和诗词匹配。

#### PoetryService

**职责:**

- 提供诗词查询和匹配接口
- 实现智能匹配算法
- 管理诗词数据

**主要方法:**

- `getRandomPoem()`: 获取随机诗词
- `getPoem(...)`: 根据条件获取诗词
- `getPoemByDynasty(dynasty)`: 根据朝代获取诗词
- `search(keyword)`: 搜索诗词

## 数据流

### 智能匹配流程

```
1. 调用 getPoem(weatherCondition: 'Rain', solarTerm: '清明', season: 'Spring')
   ↓
2. 优先级匹配
   ↓
   a. 天气匹配: 查找标签包含 '雨' 的诗词
   ↓
   b. 节气匹配: 查找标签包含 '清明' 的诗词
   ↓
   c. 季节匹配: 查找标签包含 '春' 的诗词
   ↓
3. 从匹配结果中随机选择一首
   ↓
4. 返回 Poem 对象
```

### 随机选择流程

```
1. 使用 Random 类生成随机索引
   ↓
2. 从匹配列表中选择对应索引的诗词
   ↓
3. 返回 Poem 对象
```

## 匹配算法

### 优先级匹配

```dart
Poem? getPoem({
  String? weatherCondition,
  String? solarTerm,
  String? season,
}) {
  // 1. 尝试精确匹配所有条件
  var candidates = _poems.where((poem) {
    bool matchWeather = weatherCondition == null ||
                       poem.tags.contains(_mapWeatherToTag(weatherCondition));
    bool matchSolarTerm = solarTerm == null ||
                        poem.tags.contains(solarTerm);
    bool matchSeason = season == null ||
                      poem.tags.contains(_mapSeasonToTag(season));
    return matchWeather && matchSolarTerm && matchSeason;
  }).toList();

  // 2. 如果没有精确匹配，尝试宽松匹配
  if (candidates.isEmpty) {
    candidates = _poems.where((poem) {
      return poem.tags.any((tag) =>
        _matchesAnyCondition(tag, weatherCondition, solarTerm, season)
      );
    }).toList();
  }

  // 3. 从候选中随机选择
  if (candidates.isEmpty) return null;
  return candidates[_random.nextInt(candidates.length)];
}
```

### 天气映射

```dart
String _mapWeatherToTag(String weatherCondition) {
  switch (weatherCondition.toLowerCase()) {
    case 'rain': return '雨';
    case 'snow': return '雪';
    case 'sunny': return '晴';
    case 'cloudy': return '云';
    case 'fog': return '雾';
    case 'windy': return '风';
    default: return '天气';
  }
}
```

### 季节映射

```dart
String _mapSeasonToTag(String season) {
  switch (season.toLowerCase()) {
    case 'spring': return '春';
    case 'summer': return '夏';
    case 'autumn': return '秋';
    case 'winter': return '冬';
    default: return '';
  }
}
```

## 性能优化

### 1. 延迟加载

诗词数据延迟加载，减少启动时间。

```dart
class PoetryDatabase {
  List<Poem>? _poems;

  List<Poem> get _poemsInternal {
    return _poems ??= _loadPoems();
  }

  List<Poem> getAllPoems() {
    return _poemsInternal;
  }
}
```

### 2. 随机算法优化

使用 `Random` 类替代 `DateTime.now().millisecond`，确保均匀分布。

```dart
// Before (不均匀)
return _poems[DateTime.now().millisecond % _poems.length];

// After (均匀)
static final Random _random = Random();
return _poems[_random.nextInt(_poems.length)];
```

### 3. 缓存查询结果

频繁的查询结果可以缓存，减少重复计算。

## 扩展指南

### 添加新诗词

1. 在数据库中添加新的 `Poem` 对象
2. 设置正确的标签
3. 确保格式正确

```dart
final newPoem = Poem(
  title: '新诗',
  author: '作者',
  dynasty: '朝代',
  content: ['第一句', '第二句', '第三句', '第四句'],
  tags: ['春', '雨'],
);
```

### 添加新匹配条件

1. 在 `getPoem` 方法中添加新参数
2. 实现映射逻辑
3. 更新匹配算法

### 添加新标签类型

1. 在标签系统中添加新类型
2. 为诗词添加新标签
3. 更新匹配逻辑
