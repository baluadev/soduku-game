import 'dart:isolate';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/sudoku_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sudoku/configs/const.dart';
import 'package:sudoku/effect/sound_effect.dart';
import 'package:sudoku/page/bootstrap.dart';
import 'package:sudoku/page/sudoku_game.dart';
import 'package:sudoku/state/sudoku_state.dart';

import 'configs/themes.dart';
import 'constant.dart';
import 'ml/detector.dart';
import 'models/user_profile.dart';
import 'page/enter_name.dart';
import 'size_extension.dart';
import 'splash_screen.dart';

final Logger log = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(GameHistoryAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SudokuState? _sudokuState;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _sudokuState = await _loadState();
      setState(() {});
    });
  }

  // firebase init
  _firebaseInit() async {
    if (!Constant.enableGoogleFirebase) {
      log.i("Google Firebase is disable.");
      return;
    }
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // // Flutter Not Catch Error Handler
    // FlutterError.onError = (FlutterErrorDetails details) {
    //   FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    // };
    // // Flutter Async Error Handler
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //   return true;
    // };
    // Flutter Isolate Context Error Handler
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      // await FirebaseCrashlytics.instance.recordError(
      //   errorAndStacktrace.first,
      //   errorAndStacktrace.last,
      //   fatal: true,
      // );
    }).sendPort);
  }

  // warmed up effect when application build before
  _soundEffectWarmedUp() async {
    await SoundEffect.init();
  }

  _modelWarmedUp() async {
    // warmed up sudoku-detector and digits-detector
    await DetectorFactory.getSudokuDetector();
    await DetectorFactory.getDigitsDetector();
  }

  Future<SudokuState> _loadState() async {
    await _firebaseInit();
    await _soundEffectWarmedUp();
    await _modelWarmedUp();
    await UserService.inst.init();
    return await SudokuState.resumeFromDB();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context, 390, 844);

    BootstrapPage bootstrapPage = BootstrapPage(title: "Loading");
    SudokuGamePage sudokuGamePage = SudokuGamePage(
      title: "Sudoku",
    );

    final enter = EnterName();
    return ScopedModel<SudokuState>(
      model: _sudokuState ?? SudokuState.newSudokuState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sudoku Hatchling',
        theme: AppThemes.lightTheme, // Light mode
        darkTheme: AppThemes.darkTheme, // Dark mode
        themeMode: ThemeMode.dark, // Tự đổi theo hệ thống
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        locale: Locale("en"), // i18n debug
        supportedLocales: AppLocalizations.supportedLocales,
        home: _sudokuState != null
            ? BootstrapPage(title: "Loading")
            : SplashScreen(),
        routes: <String, WidgetBuilder>{
          "/bootstrap": (context) => bootstrapPage,
          "/newGame": (context) => sudokuGamePage,
          "/gaming": (context) => sudokuGamePage,
          "/enterName": (context) => enter,
        },
      ),
    );
  }
}
