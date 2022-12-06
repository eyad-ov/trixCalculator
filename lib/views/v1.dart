import 'package:flutter/material.dart';

typedef MyCallBack = Function(int n);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trix Game"),
      ),
      body: ListView(
        children: [
          Center(child: Text(title)),
          ListView.builder(
              itemCount: 4,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: const [
                    Kingdom(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('result'),
              TextButton(
                onPressed: () {},
                child: const Text("save"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    
                  });
                },
                child: const Text("reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Kingdom extends StatefulWidget {
  const Kingdom({super.key});

  @override
  State<Kingdom> createState() => _KingdomState();
}

class _KingdomState extends State<Kingdom> {
  int resultOfKingdom = 0;
  List<int> resultOfRounds = [0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Round(
          num: 1,
          calculateResultOfKingdom: (int n) {
            setState(() {
              resultOfRounds[0] = n;
              resultOfKingdom =
                  resultOfRounds.reduce((value, element) => value + element);
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Round(
          num: 2,
          calculateResultOfKingdom: (int n) {
            setState(() {
              resultOfRounds[1] = n;
              resultOfKingdom =
                  resultOfRounds.reduce((value, element) => value + element);
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Round(
          num: 3,
          calculateResultOfKingdom: (int n) {
            setState(() {
              resultOfRounds[2] = n;
              resultOfKingdom =
                  resultOfRounds.reduce((value, element) => value + element);
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Round(
          num: 4,
          calculateResultOfKingdom: (int n) {
            setState(() {
              resultOfRounds[3] = n;
              resultOfKingdom =
                  resultOfRounds.reduce((value, element) => value + element);
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Round(
          num: 5,
          calculateResultOfKingdom: (int n) {
            setState(() {
              resultOfRounds[4] = n;
              resultOfKingdom =
                  resultOfRounds.reduce((value, element) => value + element);
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Text("Kingdom: $resultOfKingdom"),
      ],
    );
  }
}

class Round extends StatefulWidget {
  final int num;
  final MyCallBack calculateResultOfKingdom;

  const Round(
      {super.key, required this.num, required this.calculateResultOfKingdom});

  @override
  State<Round> createState() => _RoundState();
}

class _RoundState extends State<Round> {
  final images = const [
    'images/x.png',
    'images/t.jpeg',
    'images/k.jpeg',
    'images/b.jpeg',
    'images/d.jpeg',
    'images/l.jpeg'
  ];
  int currentGame = 0;
  int result = 0;
  int? currentValue;
  List<int> possibilites = [];

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Row(children: [
        Text("Round ${widget.num}"),
        const Text("     "),
        DropdownButton<int>(
          value: currentValue,
          items: possibilites.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (int? value) {
            setState(() {
              currentValue = value!;
              result = getResultOfRound();
              widget.calculateResultOfKingdom(result);
            });
          },
        ),
      ]),
      leading: Image.asset(images[currentGame]),
      trailing: Column(children: [
        TextButton(
          child: const Icon(Icons.settings_ethernet),
          onPressed: () {
            setState(() {
              currentValue = null;
              currentGame = (currentGame + 1) % 6;
              switch (currentGame) {
                case 0:
                  possibilites = [];
                  break;
                case 1:
                  possibilites = [150, 200, 250, 300, 350];
                  break;
                case 2:
                  possibilites = [0, 1];
                  break;
                case 3:
                  possibilites = [for (int i = 0; i < 5; i++) i];
                  break;
                case 4:
                  possibilites = [for (int i = 0; i < 14; i++) i];
                  break;
                case 5:
                  possibilites = [for (int i = 0; i < 14; i++) i];
                  break;
              }
              result = getResultOfRound();
              widget.calculateResultOfKingdom(result);
            });
          },
        ),
      ]),
    );
  }

  int getResultOfRound() {
    int res = 0;
    switch (currentGame) {
      case 1:
        res += currentValue ?? 0;
        break;
      case 2:
        res += (currentValue ?? 0) * -75;
        break;
      case 3:
        res += (currentValue ?? 0) * -25;
        break;
      case 4:
        res += (currentValue ?? 0) * -10;
        break;
      case 5:
        res += (currentValue ?? 0) * -15;
        break;
    }
    return res;
  }
}
