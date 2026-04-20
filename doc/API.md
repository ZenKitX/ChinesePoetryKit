# ChinesePoetryKit API 参考文档

本文档提供 ChinesePoetryKit 的完整 API 参考。

## 目录

- [PoetryService](#poetryservice)
- [PoetryDatabase](#poetrydatabase)
- [Poem](#poem)

---

## PoetryService

诗词服务类，提供诗词查询和匹配功能。

### 构造函数

```dart
PoetryService({PoetryDatabase? database})
```

**参数:**
- `database`: 诗词数据库实例（可选，默认使用内置数据库）

### 方法

#### getRandomPoem

获取随机诗词。

```dart
Poem? getRandomPoem()
```

**返回:** `Poem?`

#### getPoem

根据条件获取诗词。

```dart
Poem? getPoem({
  String? weatherCondition,
  String? solarTerm,
  String? season,
})
```

**参数:**
- `weatherCondition`: 天气条件（可选）
- `solarTerm`: 节气（可选）
- `season`: 季节（可选）

**返回:** `Poem?`

#### getPoemByDynasty

根据朝代获取诗词。

```dart
Poem? getPoemByDynasty(String dynasty)
```

**参数:**
- `dynasty`: 朝代名称（如"唐"、"宋"）

**返回:** `Poem?`

#### search

搜索诗词。

```dart
List<Poem> search(String keyword)
```

**参数:**
- `keyword`: 搜索关键词

**返回:** `List<Poem>`

#### getAllPoems

获取所有诗词。

```dart
List<Poem> getAllPoems()
```

**返回:** `List<Poem>`

#### getAvailableTags

获取所有可用的标签。

```dart
List<String> getAvailableTags()
```

**返回:** `List<String>`

#### getAvailableDynasties

获取所有可用的朝代。

```dart
List<String> getAvailableDynasties()
```

**返回:** `List<String>`

---

## PoetryDatabase

诗词数据库类。

### 构造函数

```dart
PoetryDatabase()
```

### 方法

#### getAllPoems

获取所有诗词。

```dart
List<Poem> getAllPoems()
```

**返回:** `List<Poem>`

#### getPoemsByTag

根据标签获取诗词。

```dart
List<Poem> getPoemsByTag(String tag)
```

**参数:**
- `tag`: 标签名称

**返回:** `List<Poem>`

#### getPoemsByDynasty

根据朝代获取诗词。

```dart
List<Poem> getPoemsByDynasty(String dynasty)
```

**参数:**
- `dynasty`: 朝代名称

**返回:** `List<Poem>`

#### search

搜索诗词。

```dart
List<Poem> search(String keyword)
```

**参数:**
- `keyword`: 搜索关键词

**返回:** `List<Poem>`

#### getPoemByTitle

根据标题获取诗词。

```dart
Poem? getPoemByTitle(String title)
```

**参数:**
- `title`: 诗词标题

**返回:** `Poem?`

---

## Poem

诗词模型。

### 构造函数

```dart
Poem({
  required String title,
  required String author,
  required String dynasty,
  required List<String> content,
  List<String> tags = const [],
})
```

**参数:**
- `title`: 诗词标题（必需）
- `author`: 作者（必需）
- `dynasty`: 朝代（必需）
- `content`: 诗词内容（必需）
- `tags`: 标签（可选）

### 属性

```dart
String title        // 诗词标题
String author       // 作者
String dynasty      // 朝代
List<String> content // 诗词内容（每句一句）
List<String> tags   // 标签
```
