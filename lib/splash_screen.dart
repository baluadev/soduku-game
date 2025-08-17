import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 150),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 200),
              painter: WavePainter(Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/image/sudoku_logo.png',
                  width: 250,
                  height: 270,
                ),
                Image.asset(
                  'assets/image/text_logo.png',
                  width: 242,
                  height: 135,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Color color;
  const WavePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    // Bắt đầu từ góc trên bên trái
    path.moveTo(0, 0);

    // Tạo wave hướng xuống
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.15,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      0,
      size.width,
      size.height * 0.15,
    );

    // Kéo path xuống hết dưới
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    // Vẽ shadow trước
    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 6, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
