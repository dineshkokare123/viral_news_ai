import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/news_article.dart';
import '../providers/app_provider.dart';

class ContentGeneratorScreen extends StatefulWidget {
  final NewsArticle article;

  const ContentGeneratorScreen({super.key, required this.article});

  @override
  State<ContentGeneratorScreen> createState() => _ContentGeneratorScreenState();
}

class _ContentGeneratorScreenState extends State<ContentGeneratorScreen> {
  String _selectedPlatform = 'Twitter';
  final List<String> _platforms = [
    'Twitter',
    'LinkedIn',
    'Instagram',
    'Facebook',
  ];

  @override
  void initState() {
    super.initState();
    // Clear previous content when entering screen
    Future.microtask(() => context.read<AppProvider>().clearGeneratedContent());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Generate Content')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.article.description,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Platform Selection
            Text(
              'Select Platform',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _platforms.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final platform = _platforms[index];
                  final isSelected = platform == _selectedPlatform;
                  return ChoiceChip(
                    label: Text(platform),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedPlatform = platform);
                      }
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[400],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Generate Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: provider.isGenerating
                    ? null
                    : () {
                        provider.generateContentForArticle(
                          widget.article,
                          _selectedPlatform,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: provider.isGenerating
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Generate Magic Content ✨',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 32),

            // Result Area
            if (provider.generatedContent != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Generated Content',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy),
                        tooltip: 'Copy',
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: provider.generatedContent!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Copied to clipboard!'),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        tooltip: 'Share',
                        onPressed: () {
                          Share.share(provider.generatedContent!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: Text(
                  provider.generatedContent!,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
