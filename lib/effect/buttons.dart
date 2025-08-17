import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:sudoku/configs/const.dart';
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

class BtnClose extends StatelessWidget {
  final VoidCallback? onTap;
  const BtnClose({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BtnEffect(
      onTap: onTap,
      child: Image.asset(
        'assets/image/close.png',
        scale: 2,
      ),
    );
  }
}

class BtnHint extends StatelessWidget {
  final int hint;
  final VoidCallback? onTap;
  const BtnHint({super.key, this.onTap, required this.hint});

  @override
  Widget build(BuildContext context) {
    return BtnEffect(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset('assets/image/hint.png', scale: 2),
          Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 6),
            child: Text(
              '$hint',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontFamily: fontLato,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class BtnPause extends StatelessWidget {
  final VoidCallback? onTap;
  const BtnPause({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BtnEffect(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/image/btn_menu.png',
            scale: 2,
           
          ),
          Icon(
            FlutterRemix.pause_line,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class BtnSettings extends StatelessWidget {
  final VoidCallback? onTap;
  const BtnSettings({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BtnEffect(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/image/btn_menu.png',
            scale: 2,
           
          ),
          Icon(
            FlutterRemix.user_settings_line,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
