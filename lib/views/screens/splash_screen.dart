import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pennypath/views/screens/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _lottieController;
  late final AnimationController _textAnimationController;
  late final Animation<double> _textOpacityAnimation;

  bool _isLottieLoaded = false;

  @override
  void initState() {
    super.initState();
    print("SplashScreen initState");

    WidgetsBinding.instance.addObserver(this);

    _lottieController = AnimationController(vsync: this);
    print("Lottie controller created");

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2450),
    );
    print("Text animation controller created");

    _textOpacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_textAnimationController);

    _lottieController.addStatusListener((status) {
      print("Lottie animation status: $status");
      if (status == AnimationStatus.completed) {
        _textAnimationController.forward();
      }
    });

    _textAnimationController.addStatusListener((status) {
      print("Text animation status: $status");
      if (status == AnimationStatus.completed) {
        print("Text animation completed, navigating...");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    });
  }

  void _startLottieAnimation() {
  if (_isLottieLoaded) {
    print("Starting Lottie animation with 1 second delay");
    Future.delayed(const Duration(seconds: 1), () {
      _lottieController
        ..reset()
        ..forward();
    });
  } else {
    print("Trying to start Lottie animation but not loaded yet");
  }
}


  @override
  void dispose() {
    print("SplashScreen dispose");
    WidgetsBinding.instance.removeObserver(this);
    _lottieController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("App lifecycle state changed: $state");
    if (state == AppLifecycleState.resumed) {
      print("App resumed - restarting animations");
      _startLottieAnimation();
      _textAnimationController.reset();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    print("Building SplashScreen widget");
    return Scaffold(
      backgroundColor: const Color(0xFFE6FFFA),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/Money.json',
              controller: _lottieController,
              onLoaded: (composition) {
                print("Lottie composition loaded with duration: ${composition.duration}");
                _lottieController.duration = composition.duration;
                _isLottieLoaded = true;
                _startLottieAnimation();
              },
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _textOpacityAnimation,
              child: const Text(
                'PennyPath',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
