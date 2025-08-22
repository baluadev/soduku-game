import 'dart:async';
import 'dart:isolate';

// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/sudoku_localizations.dart';
import 'package:logger/logger.dart' hide Level;
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sudoku/configs/const.dart';
import 'package:sudoku/effect/buttons.dart';
import 'package:sudoku/effect/egg_loading.dart';
// import 'package:sudoku/effect/sound_effect.dart';
import 'package:sudoku/models/user_profile.dart';
import 'package:sudoku/native/sudoku.dart';
import 'package:sudoku/page/onboarding.dart';
import 'package:sudoku/size_extension.dart';
import 'package:sudoku/splash_screen.dart';
import 'package:sudoku/state/sudoku_state.dart';
import 'package:sudoku/sudoku_dart/lib/sudoku_dart.dart';
// import 'package:sudoku/util/localization_util.dart';

// import 'ai_scan.dart';

final Logger log = Logger();

List levelData = [
  {
    'id': 0,
    'title': 'Eggshell',
    'subtitle': 'Beginner',
    'icon': 'assets/image/lv1.png',
  },
  {
    'id': 1,
    'title': 'Cracked',
    'subtitle': 'Easy',
    'icon': 'assets/image/lv2.png',
  },
  {
    'id': 2,
    'title': 'Chick',
    'subtitle': 'Intermediate',
    'icon': 'assets/image/lv3.png',
  },
  {
    'id': 3,
    'title': 'Fledgeling',
    'subtitle': 'Advanced',
    'icon': 'assets/image/lv4.png',
  },
  {
    'id': 4,
    'title': 'Wise Owl',
    'subtitle': 'Wise Owl',
    'icon': 'assets/image/lv5.png',
  },
];

class BootstrapPage extends StatefulWidget {
  BootstrapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BootstrapPageState createState() => _BootstrapPageState();
}

// Widget _buttonWrapper(
//     BuildContext context, Widget childBuilder(BuildContext content)) {
//   return Container(
//       margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//       width: 300,
//       height: 60,
//       child: childBuilder(context));
// }

// Widget _aiSolverButton(BuildContext context) {
//   String buttonLabel = AppLocalizations.of(context)!.menuAISolver;
//   return Offstage(
//       offstage: false,
//       child: _buttonWrapper(
//           context,
//           (content) => CupertinoButton(
//                 color: Colors.blue,
//                 child: Text(
//                   buttonLabel,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onPressed: () async {
//                   log.d("AI Solver Scanner");
//                   WidgetsFlutterBinding.ensureInitialized();

//                   final cameras = await availableCameras();
//                   final firstCamera = cameras.first;
//                   final aiScanPage = AIScanPage(camera: firstCamera);

//                   Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                           opaque: false,
//                           pageBuilder: (BuildContext context, _, __) {
//                             return aiScanPage;
//                           }));
//                 },
//               )));
// }

// Widget _continueGameButton(BuildContext context) {
//   return ScopedModelDescendant<SudokuState>(builder: (context, child, state) {
//     String buttonLabel = AppLocalizations.of(context)!.menuContinueGame;
//     String continueMessage =
//         "${LocalizationUtils.localizationLevelName(context, state.level ?? Level.eggshell)} - ${state.timer}";
//     return Offstage(
//       offstage: state.status != SudokuGameStatus.pause,
//       child: Container(
//         width: 300,
//         height: 80,
//         decoration: BoxDecoration(
//           border: Border.all(color: Theme.of(context).colorScheme.secondary),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: GestureDetector(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 child: Text(
//                   buttonLabel,
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 child: Text(
//                   continueMessage,
//                   style: TextStyle(fontSize: 13),
//                 ),
//               )
//             ],
//           ),
//           onTap: () {
//             Navigator.pushNamed(context, "/gaming");
//           },
//         ),
//       ),
//     );
//   });
// }

// Widget _newGameButton(BuildContext context) {
//   return _buttonWrapper(
//       context,
//       (_) => CupertinoButton(
//           color: Colors.blue,
//           child: Text(
//             AppLocalizations.of(context)!.menuNewGame,
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           onPressed: () {
//             // cancel  button
//             Widget cancelButton = SizedBox(
//                 height: 60,
//                 width: MediaQuery.of(context).size.width,
//                 child: Container(
//                     child: CupertinoButton(
//                   child: Text(
//                     AppLocalizations.of(context)!.levelCancel,
//                     style: TextStyle(color: Colors.black45),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop(false);
//                   },
//                 )));

//             // iterative difficulty build buttons
//             List<Widget> buttons = [];
//             Level.values.forEach((Level level) {
//               String levelName =
//                   LocalizationUtils.localizationLevelName(context, level);
//               buttons.add(SizedBox(
//                   height: 60,
//                   width: MediaQuery.of(context).size.width,
//                   child: Container(
//                       margin: EdgeInsets.all(1.0),
//                       child: CupertinoButton(
//                         child: Text(
//                           levelName,
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         onPressed: () async {
//                           log.d(
//                               "begin generator Sudoku with level : $levelName");
//                           await _sudokuGenerate(context, level);
//                           Navigator.popAndPushNamed(context, "/gaming");
//                         },
//                       ))));
//             });
//             buttons.add(cancelButton);

//             showCupertinoModalBottomSheet(
//               context: context,
//               barrierColor: Colors.black38,
//               topRadius: Radius.circular(20),
//               builder: (context) {
//                 return SafeArea(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Material(
//                         child: Container(
//                             height: 320,
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: buttons))),
//                   ),
//                 );
//               },
//             );
//           }));
// }

void _internalSudokuGenerate(List<dynamic> args) {
  Level level = args[0];
  SendPort sendPort = args[1];

  DateTime beginTime, endTime;
  beginTime = DateTime.now();
  // 生成题目速度比较慢,尝试使用native生成 , 解题普遍速度较快,继续使用 sudoku_dart
  // native 生成 加上 dart 解题 速度提升非常显著
  List<int> puzzle = SudokuNativeHelper.instance.generate(level.index);
  Sudoku sudoku = Sudoku(puzzle);
  // Sudoku sudoku = Sudoku.generate(level);
  endTime = DateTime.now();
  var consumingTie =
      endTime.millisecondsSinceEpoch - beginTime.millisecondsSinceEpoch;
  log.d("数独生成完毕 耗时: $consumingTie'ms");
  sendPort.send(sudoku);
}

Future _sudokuGenerate(BuildContext context, Level level) async {
  String sudokuGenerateText = AppLocalizations.of(context)!.sudokuGenerateText;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EggLoading(),
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("$sudokuGenerateText ...",
                    style: TextStyle(fontSize: 13)))
          ],
        ),
      ),
    ),
  );

  ReceivePort receivePort = ReceivePort();

  Isolate isolate = await Isolate.spawn(
      _internalSudokuGenerate, [level, receivePort.sendPort]);
  var data = await receivePort.first;
  Sudoku sudoku = data;
  SudokuState state = ScopedModel.of<SudokuState>(context);
  state.initialize(sudoku: sudoku, level: level);
  state.updateStatus(SudokuGameStatus.pause);
  receivePort.close();
  isolate.kill(priority: Isolate.immediate);
  log.d("receivePort.listen done!");

  // dismiss dialog
  Navigator.pop(context);
}

class _BootstrapPageState extends State<BootstrapPage> {
  @override
  void initState() {
    super.initState();
  }

  int selectLv = 0;

  void selectLevel(int lv) {
    selectLv = lv;
    reloadView();
  }

  void reloadView() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildMain() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: [
              CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 200),
                  painter:
                      WavePainter(Theme.of(context).scaffoldBackgroundColor)),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: BtnRed(
                    title: 'Let’s Play!',
                    onTap: () async {
                      final level =
                          Level.values.where((e) => e.index == selectLv).first;
                      await _sudokuGenerate(context, level);
                      Navigator.pushNamed(context, "/gaming");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Choose Your Challenge Level:",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 12),
              ...levelData.map((e) {
                final id = e['id'];

                return GestureDetector(
                  onTap: () {
                    selectLevel(id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Image.asset(
                          e['icon'],
                          scale: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                e['title'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 32.r, color: Colors.black),
                              ),
                              Text(
                                '(${e['subtitle']})',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontSize: 16.r,
                                      fontFamily: fontLato,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        selectLv == id
                            ? Image.asset(
                                'assets/image/on_toogle.png',
                                scale: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              )
                            : Image.asset(
                                'assets/image/off_toogle.png',
                                scale: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = UserService.inst.getProfile();
    if (profile == null) {
      return Onboarding();
    }

    return ScopedModelDescendant<SudokuState>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(),
          actions: [
            BtnSettings(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            SizedBox(width: 24),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: _buildMain(),
        ),
      ),
    );
  }
}
