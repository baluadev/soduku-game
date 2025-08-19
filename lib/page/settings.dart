import 'package:flutter/material.dart';
import 'package:sudoku/effect/buttons.dart';
import 'package:sudoku/splash_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          BtnClose(
            onTap: () => Navigator.of(context).popAndPushNamed('/bootstrap'),
          ),
          SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 200),
                    painter: WavePainter(Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Sound',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  ListTile(
                    title: Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
