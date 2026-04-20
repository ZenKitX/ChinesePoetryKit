import 'package:flutter/material.dart';
import 'package:chinese_poetry_kit/chinese_poetry_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChinesePoetryKit Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const PoetryExamplePage(),
    );
  }
}

class PoetryExamplePage extends StatefulWidget {
  const PoetryExamplePage({super.key});

  @override
  State<PoetryExamplePage> createState() => _PoetryExamplePageState();
}

class _PoetryExamplePageState extends State<PoetryExamplePage> {
  Poem? _currentPoem;
  String _selectedMode = 'Random';

  @override
  void initState() {
    super.initState();
    _getRandomPoem();
  }

  void _getRandomPoem() {
    setState(() {
      _currentPoem = PoetryService.getRandomPoem();
    });
  }

  void _getPoemByWeather(String weather) {
    setState(() {
      _currentPoem = PoetryService.getPoem(weatherCondition: weather);
    });
  }

  void _getPoemBySeason(String season) {
    setState(() {
      _currentPoem = PoetryService.getPoem(season: season);
    });
  }

  void _getPoemByDynasty(String dynasty) {
    final poems = PoetryService.getPoemsByDynasty(dynasty);
    if (poems.isNotEmpty) {
      setState(() {
        _currentPoem = poems.first;
      });
    }
  }

  void _searchPoem(String keyword) {
    final results = PoetryService.search(keyword);
    if (results.isNotEmpty) {
      setState(() {
        _currentPoem = results.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChinesePoetryKit Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          _buildModeSelector(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _currentPoem != null ? _buildPoemCard() : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _buildModeChip('Random', () {
                _selectedMode = 'Random';
                _getRandomPoem();
              }),
              _buildModeChip('Weather: Rain', () {
                _selectedMode = 'Weather: Rain';
                _getPoemByWeather('Rain');
              }),
              _buildModeChip('Weather: Snow', () {
                _selectedMode = 'Weather: Snow';
                _getPoemByWeather('Snow');
              }),
              _buildModeChip('Season: Spring', () {
                _selectedMode = 'Season: Spring';
                _getPoemBySeason('Spring');
              }),
              _buildModeChip('Season: Autumn', () {
                _selectedMode = 'Season: Autumn';
                _getPoemBySeason('Autumn');
              }),
              _buildModeChip('Dynasty: Tang', () {
                _selectedMode = 'Dynasty: Tang';
                _getPoemByDynasty('唐');
              }),
              _buildModeChip('Dynasty: Song', () {
                _selectedMode = 'Dynasty: Song';
                _getPoemByDynasty('宋');
              }),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Search poems by keyword',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: _searchPoem,
          ),
        ],
      ),
    );
  }

  Widget _buildModeChip(String label, VoidCallback onTap) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: _selectedMode == label
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
    );
  }

  Widget _buildPoemCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentPoem!.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  _currentPoem!.author,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _currentPoem!.dynasty,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_currentPoem!.tags != null && _currentPoem!.tags!.isNotEmpty)
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _currentPoem!.tags!.split(',').map((tag) {
                  return Chip(
                    label: Text(tag.trim()),
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _currentPoem!.content.split('，').asMap().entries.map((entry) {
                  final index = entry.key;
                  final line = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '${(index + 1).toString().padLeft(2, '0')}. ${line.trim()}。',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontFamily: 'serif',
                            height: 1.8,
                          ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _getRandomPoem,
                icon: const Icon(Icons.refresh),
                label: const Text('Next Poem'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Mode: $_selectedMode',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
