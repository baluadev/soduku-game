import 'package:flutter/material.dart';

class EggLoading extends StatefulWidget {
  const EggLoading({super.key});

  @override
  State<EggLoading> createState() => _EggLoadingState();
}

class _EggLoadingState extends State<EggLoading> with TickerProviderStateMixin {
  late final AnimationController _controller1;
  late final AnimationController _controller2;
  late final AnimationController _controller3;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 460),
    )..repeat(reverse: true);

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..repeat(reverse: true);

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Widget _buildEgg(AnimationController controller, String asset) {
    final bounce = Tween<double>(begin: 0, end: -50).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    final scale = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, bounce.value),
          child: Transform.scale(
            scale: scale.value,
            child: child,
          ),
        );
      },
      child: Image.asset(
        asset,
        scale: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEgg(_controller1, 'assets/image/loading1.png'),
          SizedBox(width: 10),
          _buildEgg(_controller2, 'assets/image/loading2.png'),
          SizedBox(width: 10),
          _buildEgg(_controller3, 'assets/image/loading3.png'),
        ],
      ),
    );
  }
}
