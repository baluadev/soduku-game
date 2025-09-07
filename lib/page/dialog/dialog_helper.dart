import 'package:flutter/material.dart';
import 'package:sudoku/effect/egg_loading.dart';
import 'package:sudoku/helper/navigation_service.dart';

class DialogHelper {
  static void showLoading({String? title}) {
    _showGeneralDialog(
      Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EggLoading(),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  "${title ?? 'Loading'} ...",
                  style: TextStyle(fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> hideLoading() async {
    await back();
  }

  static Future<void> back() async {
    await Navigator.maybePop(NavigationService.inst.curContext);
  }

  static dynamic _showGeneralDialog(
    Widget child, {
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: NavigationService.inst.curContext,
      barrierDismissible: barrierDismissible,
      builder: (c) {
        return child;
      },
    );
  }
}
