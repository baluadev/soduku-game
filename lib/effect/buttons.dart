import 'package:flutter/material.dart';
import 'package:sudoku/size_extension.dart';

class BtnEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  const BtnEffect({super.key, required this.child, this.onTap});

  @override
  State<BtnEffect> createState() => _BtnEffectState();
}

class _BtnEffectState extends State<BtnEffect> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onTap?.call();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        transform: Matrix4.translationValues(0, _isPressed ? 3 : 0, 0),
        child: widget.child,
      ),
    );
  }
}

class BtnRed extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const BtnRed({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BtnEffect(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/image/btn_red.png',
            scale: 2,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 32.r, color: Colors.white),
          ),
        ],
      ),
    );
  }
}



class BtnWhite extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const BtnWhite({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/image/btn_white.png',
            scale: 2,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 32.r, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
