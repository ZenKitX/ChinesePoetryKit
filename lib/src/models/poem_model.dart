/// Classical Chinese poem model
class Poem {
  /// Poem title
  final String title;

  /// Author name
  final String author;

  /// Dynasty (唐, 宋, 元, 明, 清, etc.)
  final String dynasty;

  /// Poem content
  final String content;

  /// Tags (e.g., "雨,春", "雪,冬")
  final String? tags;

  Poem({
    required this.title,
    required this.author,
    required this.dynasty,
    required this.content,
    this.tags,
  });

  /// Create poem from JSON
  factory Poem.fromJson(Map<String, dynamic> json) {
    return Poem(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      dynasty: json['dynasty'] ?? '',
      content: json['content'] ?? '',
      tags: json['tags'],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'dynasty': dynasty,
      'content': content,
      if (tags != null) 'tags': tags,
    };
  }

  /// Check if poem contains keyword
  bool containsKeyword(String keyword) {
    return title.contains(keyword) ||
           author.contains(keyword) ||
           dynasty.contains(keyword) ||
           content.contains(keyword) ||
           (tags?.contains(keyword) ?? false);
  }

  /// Get formatted display text
  String get displayText => '$content\n\n—— $author《$title》';

  @override
  String toString() {
    return 'Poem(title: $title, author: $author, dynasty: $dynasty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Poem &&
        other.title == title &&
        other.author == author &&
        other.dynasty == dynasty &&
        other.content == content;
  }

  @override
  int get hashCode => Object.hash(title, author, dynasty, content);
}
