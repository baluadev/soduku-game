import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sudoku/effect/buttons.dart';
import 'package:sudoku/models/user_profile.dart';
import 'package:sudoku/splash_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Hey, ${UserService.inst.getProfile()?.name ?? ''}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
                    trailing: ValueListenableBuilder(
                      valueListenable: UserService.inst.profileBox.listenable(),
                      builder: (context, value, child) {
                        final enable = UserService.inst.enableSound();
                        return BtnToggle(
                          enable: enable,
                          onTap: () {
                            UserService.inst.toogleEnableSound(!enable);
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: ValueListenableBuilder(
                      valueListenable: UserService.inst.profileBox.listenable(),
                      builder: (context, value, child) {
                        final enable = UserService.inst.darkMode() ?? false;
                        return BtnToggle(
                          enable: enable,
                          onTap: () {
                            UserService.inst.toogleDarkMode(!enable);
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Policies & Terms',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
