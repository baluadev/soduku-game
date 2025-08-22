import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sudoku/configs/const.dart';
import 'package:sudoku/effect/buttons.dart';
import 'package:sudoku/models/user_profile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<GameHistory> list = UserService.inst.getAllHistories();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BtnClose(
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          ...list.map((e) {
            final title = e.isWin ? 'Winner' : 'Losser';

            return ExpansionTile(
              title: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 32,
                    ),
              ),
              children: [
                cell(
                  'Time Taken: ',
                  e.timeTaken.toString(),
                ),
                cell(
                  'Life Used: ',
                  e.lifeUsed.toString(),
                ),
                cell(
                  'Hint Used: ',
                  e.hintsUsed.toString(),
                ),
                cell(
                  'Stars Earned: ',
                  e.starsEarned.toString(),
                ),
                cell(
                  'Start Time: ',
                  e.startTime.toString(),
                ),
                cell(
                  'End Time: ',
                  e.endTime.toString(),
                ),
                GestureDetector(
                  onTap: () {
                    Share.share('🏆 Sudoku Winner! \nTime: ${e.timeTaken} ⏳ | Stars: ${e.starsEarned} ⭐ \n #SudokuHatchling #SudokuChallenge #BrainGame');
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FlutterRemix.share_forward_line),
                        SizedBox(width: 5),
                        Text(
                          'Share',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          })
        ],
      ),
    );
  }

  Widget cell(title, subtitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 20,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontFamily: fontLato,
                    fontSize: 18,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
