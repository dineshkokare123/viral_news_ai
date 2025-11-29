import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SentimentAnalysisWidget extends StatelessWidget {
  final Map<String, double> sentimentData;
  final bool isLoading;

  const SentimentAnalysisWidget({
    super.key,
    required this.sentimentData,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Analyzing Emotional Tone...',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    if (sentimentData.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                'Emotional Analysis',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...sentimentData.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${(entry.value * 100).toInt()}%',
                        style: TextStyle(
                          color: _getColorForEmotion(entry.key),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: entry.value,
                      backgroundColor: Colors.grey[800],
                      color: _getColorForEmotion(entry.key),
                      minHeight: 8,
                    ),
                  ).animate().scaleX(
                    duration: 800.ms,
                    curve: Curves.easeOutQuart,
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    ).animate().fadeIn().moveY(begin: 20, end: 0);
  }

  Color _getColorForEmotion(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'excitement':
        return Colors.orange;
      case 'fear':
        return Colors.purple;
      case 'joy':
        return Colors.green;
      case 'controversy':
        return Colors.red;
      case 'trust':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
