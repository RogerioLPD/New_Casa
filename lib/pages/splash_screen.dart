import 'package:flutter/material.dart';
import 'package:nucleo/routes.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navegar para a próxima tela
        Navigator.pushNamedAndRemoveUntil(context, Routes.loginespecificador,(route) => false);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 250, 250, 250),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child:  Image.asset('assets/images/Nucleo.png',
            width: 800,

          ),
        ),
      ),
    );
  }
}