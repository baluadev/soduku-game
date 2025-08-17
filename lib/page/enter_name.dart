import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/effect/buttons.dart';
import 'package:sudoku/models/user_profile.dart';
import 'package:sudoku/size_extension.dart';

class EnterName extends StatefulWidget {
  const EnterName({super.key});

  @override
  State<EnterName> createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {
  List<TextEditingController> controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(
    5,
    (index) => FocusNode(),
  );

  List<FocusNode> focusNodes2 = List.generate(
    5,
    (index) => FocusNode(),
  );

  @override
  void initState() {
    // focusNodes[0].requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    controllers.map((e) => e.dispose());
    focusNodes.map((e) => e.dispose());
    focusNodes2.map((e) => e.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/image/pattern.png', fit: BoxFit.cover),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.4,
                child: CustomPaint(
                  painter: YellowCurvePainter(),
                ),
              ),
              Image.asset(
                'assets/image/text_logo.png',
                scale: 2,
              ),
              Positioned(
                bottom: 10,
                child: Image.asset(
                  'assets/image/owl2.png',
                  scale: 3,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              margin: EdgeInsets.only(left: 35, right: 35, top: 100),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...controllers.map(
                    (controller) => Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.only(left: 10),
                        height: 72,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFE2E0CB),
                              width: 4,
                            ),
                          ),
                        ),
                        child: Baseline(
                          baseline: 50,
                          baselineType: TextBaseline.alphabetic,
                          child: KeyboardListener(
                            focusNode:
                                focusNodes2[controllers.indexOf(controller)],
                            onKeyEvent: (KeyEvent event) {
                              if (event is KeyDownEvent &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.backspace) {
                                final index = controllers.indexOf(controller);
                                if (controller.text.isEmpty && index > 0) {
                                  FocusScope.of(context)
                                      .requestFocus(focusNodes[index - 1]);
                                }
                              }
                            },
                            child: TextField(
                              controller: controller,
                              cursorColor: Color(0xFFE2E0CB),
                              cursorWidth: 4,
                              cursorHeight: 50,
                              maxLength: 1,
                              focusNode:
                                  focusNodes[controllers.indexOf(controller)],
                              style: TextStyle(
                                fontSize: 60.r,
                                color: Theme.of(context).colorScheme.primary,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              onChanged: (value) {
                                final index = controllers.indexOf(controller);
                                if (value.isNotEmpty) {
                                  if (index < controllers.length - 1) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index + 1]);
                                  } else {
                                    FocusScope.of(context)
                                        .unfocus(); // thoát bàn phím nếu hết ô
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: BtnRed(
                title: 'Continue',
                onTap: () {
                  if (controllers
                      .every((controller) => controller.text.isNotEmpty)) {
                    final name = controllers.map((e) => e.text).join();
                    UserService.inst.createProfile(name).then((value) =>
                        Navigator.popAndPushNamed(context, '/bootstrap'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class YellowCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.black.withOpacity(0.2), // shadow phía dưới
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Vẽ shadow layer trước
    Path shadowPath = Path()
      ..lineTo(0, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 1.2,
        size.width,
        size.height * 0.85,
      )
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(shadowPath, paint);

    // Vẽ nền vàng
    final yellowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFFFCC00);

    Path yellowPath = Path()
      ..lineTo(0, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 1.2,
        size.width,
        size.height * 0.85,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(yellowPath, yellowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
