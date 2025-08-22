import 'package:flutter/material.dart';
import 'package:sudoku/effect/buttons.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Page1(onNext: onNext),
          Page2(onNext: onNext),
          Page3(onNext: onNext),
          Page4(onNext: onNext),
        ],
      ),
    );
  }

  void onNext() {
    final page = _pageController.page;

    switch (page) {
      case 0:
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
        break;
      case 1:
        _pageController.animateToPage(
          2,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
        break;
      case 2:
        _pageController.animateToPage(
          3,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
        break;
      case 3:
        Navigator.of(context).popAndPushNamed('/enterName');
        break;
      default:
    }
  }
}

class Page1 extends StatelessWidget {
  final VoidCallback onNext;
  const Page1({super.key, required this.onNext});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 120),
            Text(
              'Progressive Sudoku Challenges',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.asset(
                'assets/image/feature1.png',
                scale: 2,
              ),
            ),
            Expanded(
              child: Text(
                'Grow from Eggshell to Wise Owl \nas you solve puzzles \ndesigned for every skill level!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Image.asset(
            'assets/image/onboarding1.png',
            scale: 2,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: SafeArea(child: BtnRed(title: 'Next', onTap: onNext)),
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  final VoidCallback onNext;
  const Page2({super.key, required this.onNext});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 120),
            Text(
              'Daily Egg Hunt',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.asset(
                'assets/image/feature2.png',
                scale: 2,
              ),
            ),
            Expanded(
              child: Text(
                'Crack hidden rewards every day \nwith our Daily Egg Hunt!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Image.asset(
            'assets/image/onboarding1.png',
            scale: 2,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(child: BtnRed(title: 'Next', onTap: onNext)),
        ),
      ],
    );
  }
}

class Page3 extends StatelessWidget {
  final VoidCallback onNext;
  const Page3({super.key, required this.onNext});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 120),
            Text(
              'Night Owl Mode',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.asset(
                'assets/image/feature2.png',
                scale: 2,
              ),
            ),
            Expanded(
              child: Text(
                'Solve Sudoku puzzles in style,\nday or night!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Image.asset(
            'assets/image/onboarding1.png',
            scale: 2,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: SafeArea(child: BtnRed(title: 'Next', onTap: onNext)),
        ),
      ],
    );
  }
}

class Page4 extends StatelessWidget {
  final VoidCallback onNext;
  const Page4({super.key, required this.onNext});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text(
              'Welcome to',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.asset(
                  'assets/image/text_logo.png',
                  color: Theme.of(context).colorScheme.secondary,
                  scale: 2,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Image.asset(
            'assets/image/onboarding2.png',
            scale: 2,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          top: 120,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/image/grid.png',
            scale: 2,
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 65),
            child: Image.asset(
              'assets/image/owl2.png',
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: SafeArea(child: BtnRed(title: 'Let’s Start!', onTap: onNext)),
        ),
      ],
    );
  }
}
