import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trix/crud/crud.dart';
import 'package:trix/views/main_view.dart';

import '../Data/game.dart';
import 'components/kingdom.dart';
import 'components/result_calculater.dart';

class GameView extends StatefulWidget {
  final String team1;
  final String team2;
  final int team;
  const GameView(
      {super.key,
      required this.team1,
      required this.team2,
      required this.team});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late String title = widget.team == 1 ? widget.team1 : widget.team2;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ResultCalculater(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Trix Game"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MainView();
                  }),
                  (route) => false,
                );
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
            ListView.builder(
                itemCount: 4,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Kingdom(
                        kingdomNumber: index + 1,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<ResultCalculater>(
                    builder: (context, resultCalculater, child) {
                  int res = resultCalculater.calculateResultOfGame();
                  Color color = res >= 0 ? Colors.green : Colors.red;
                  return Text(
                    'Result $res',
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                    ),
                  );
                }),
                Consumer<ResultCalculater>(
                    builder: (context, resultCalculater, child) {
                  return TextButton.icon(
                    onPressed: () async {
                      DateTime time = DateTime.now();
                      Game game = Game(
                        id: null,
                        team1: widget.team1,
                        team2: widget.team2,
                        numOfTeam: widget.team,
                        year: time.year,
                        month: time.month,
                        day: time.day,
                        hour: time.hour,
                        minute: time.minute,
                        result: resultCalculater.calculateResultOfGame(),
                      );
                      TrixDataBase db = TrixDataBase.instance;
                      await db.createGame(game);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text("Game saved!"),
                            );
                          });
                    },
                    icon: const Icon(Icons.save_alt),
                    label: const Text("save"),
                  );
                }),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameView(
                              team1: widget.team1,
                              team2: widget.team2,
                              team: widget.team)),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.restore),
                  label: const Text("reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
