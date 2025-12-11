import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NewsIconWithSparkles extends StatefulWidget {
  final Color color;
  final int sparkleCount;
  final double starSize;
  final double maxDx;
  final double maxDy;

  const NewsIconWithSparkles({
    Key? key,
    required this.color,
    this.sparkleCount = 9,
    this.starSize = 4,
    this.maxDx = 10,
    this.maxDy = 10,
  }) : super(key: key);

  @override
  State<NewsIconWithSparkles> createState() => _NewsIconWithSparklesState();
}

class _NewsIconWithSparklesState extends State<NewsIconWithSparkles>
    with TickerProviderStateMixin {
  final Random _random = Random();
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _fadeAnimations = [];
  final List<Animation<double>> _scaleAnimations = [];
  final List<Offset> _positions = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.sparkleCount; i++) {
      // Posiciones aleatorias cercanas al icono
      double dx = (_random.nextDouble() * 2 * widget.maxDx) - widget.maxDx;
      double dy = (_random.nextDouble() * 2 * widget.maxDy) - widget.maxDy;
      _positions.add(Offset(dx, dy));

      // Animación independiente
      final duration = Duration(milliseconds: 1000 + _random.nextInt(600));
      final controller = AnimationController(vsync: this, duration: duration);

      final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );

      final scale = Tween<double>(begin: 0.5, end: 1.3).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut),
      );

      _controllers.add(controller);
      _fadeAnimations.add(fade);
      _scaleAnimations.add(scale);

      // Delay escalonado para que aparezcan una tras otra
      Future.delayed(Duration(milliseconds: i * 500), () {
        if (mounted) controller.repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          Ionicons.newspaper_outline,
          size: 35,
          color: widget.color,
        ),
        for (int i = 0; i < widget.sparkleCount; i++)
          Positioned(
            left: 18 + _positions[i].dx,
            top: 18 + _positions[i].dy,
            child: FadeTransition(
              opacity: _fadeAnimations[i],
              child: ScaleTransition(
                scale: _scaleAnimations[i],
                child: Icon(
                  Icons.star_rounded,
                  size: widget.starSize,
                  color: Colors.amberAccent.withValues(
                    alpha: 0.9,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
