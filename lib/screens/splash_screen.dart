import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Login Screen after animation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo Icon
            Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                )
                .animate()
                .scale(duration: 600.ms, curve: Curves.easeOutBack)
                .then(delay: 200.ms)
                .shimmer(
                  duration: 1200.ms,
                  color: Colors.white.withOpacity(0.5),
                )
                .then(delay: 200.ms)
                .shake(hz: 4, curve: Curves.easeInOutCubic),

            const SizedBox(height: 24),

            // Animated Text
            Column(
              children: [
                Text(
                      'VIRAL NEWS AI',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 400.ms)
                    .moveY(begin: 20, end: 0),

                const SizedBox(height: 8),

                Text(
                  'Create Content That Trends',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[400],
                    letterSpacing: 0.5,
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 800.ms),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
