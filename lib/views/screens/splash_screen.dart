import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pennypath/auth_wrapper.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';
import 'package:provider/provider.dart';

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

    WidgetsBinding.instance.addObserver(this);

    _lottieController = AnimationController(vsync: this);

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2450),
    );

    _textOpacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_textAnimationController);

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textAnimationController.forward();
      }
    });

    _textAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Provider.of<AuthViewModel>(context, listen: false).initAuth().then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AuthWrapper()),
          );
        });
      }
    });
  }

  void _startLottieAnimation() {
  if (_isLottieLoaded) {
    Future.delayed(const Duration(seconds: 2), () {
      _lottieController
        ..reset()
        ..forward();
    });
  } else {
  }
}


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lottieController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startLottieAnimation();
      _textAnimationController.reset();
    } 
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
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
