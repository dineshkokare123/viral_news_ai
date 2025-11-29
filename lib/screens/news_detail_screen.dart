import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/news_article.dart';
import '../services/gemini_service.dart';
import '../widgets/sentiment_analysis_widget.dart';
import 'content_generator_screen.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  final FlutterTts _flutterTts = FlutterTts();
  final GeminiService _geminiService = GeminiService();
  bool _isSpeaking = false;

  Map<String, double> _sentimentData = {};
  bool _isAnalyzingSentiment = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _initializeTts();
    _analyzeSentiment();
  }

  Future<void> _analyzeSentiment() async {
    final data = await _geminiService.analyzeSentiment(
      widget.article.title,
      widget.article.description,
    );
    if (mounted) {
      setState(() {
        _sentimentData = data;
        _isAnalyzingSentiment = false;
      });
    }
  }

  Future<void> _initializeVideo() async {
    if (widget.article.videoUrl != null) {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.article.videoUrl!),
      );
      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: false,
        looping: false,
        aspectRatio: 16 / 9,
        placeholder: Container(
          color: Colors.black,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
      setState(() {});
    }
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  Future<void> _speak() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() {
        _isSpeaking = false;
      });
    } else {
      setState(() {
        _isSpeaking = true;
      });
      await _flutterTts.speak(
        "${widget.article.title}. ${widget.article.description}",
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
        actions: [
          IconButton(
            icon: Icon(
              _isSpeaking ? Icons.stop_circle : Icons.record_voice_over,
            ),
            onPressed: _speak,
            tooltip: _isSpeaking ? 'Stop Reading' : 'Read News',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Player or Image
            if (_chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(controller: _chewieController!),
              )
            else
              Image.network(
                widget.article.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[800],
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.article.category,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.article.source,
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    widget.article.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    widget.article.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[300],
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Sentiment Analysis Widget
                  SentimentAnalysisWidget(
                    sentimentData: _sentimentData,
                    isLoading: _isAnalyzingSentiment,
                  ),

                  const SizedBox(height: 40),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ContentGeneratorScreen(article: widget.article),
                          ),
                        );
                      },
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text(
                        'Generate Viral Content',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
