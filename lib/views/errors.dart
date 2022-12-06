import 'package:flutter/material.dart';

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
        actions: [
          Text(title),
        ],
      ),
      body: ListView.builder(
          itemCount: 4,
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
    );
  }
}

class Kingdom extends StatelessWidget {
  const Kingdom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Round(num: 1),
        SizedBox(
          height: 10,
        ),
        Round(num: 2),
        SizedBox(
          height: 10,
        ),
        Round(num: 3),
        SizedBox(
          height: 10,
        ),
        Round(num: 4),
        SizedBox(
          height: 10,
        ),
        Round(num: 5),
      ],
    );
  }
}

class Round extends StatefulWidget {
  final int num;

  const Round({super.key, required this.num});

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
  List<int> possibilites = [];

  @override
  Widget build(BuildContext context) {
    // when DropDown rerendered it seems differnt objects of it sharing same stateObj ???

    return ListTile(
      title: Row(children: [
        Text("Round ${widget.num}"),
        const Text("     "),
        DropDown(
          possibilites: possibilites,
        ),
      ]),
      leading: Image.asset(images[currentGame]),
      trailing: Column(children: [
        TextButton(
          child: const Icon(Icons.settings_ethernet),
          onPressed: () {
            setState(() {
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
            });
          },
        ),
      ]),
    );
  }

/*
  Widget findOut() {
    if (currentGame > 0) {
      if (currentGame == 1) {
        return DropDown(number: 0, isTrix: true);
      } else {
        int num = 0;
        switch (currentGame) {
          case 2:
            num = 2;
            break;
          case 3:
            num = 5;
            break;
          case 4:
            num = 14;
            break;
          case 5:
            num = 14;
            break;
        }
        return DropDown(number: num, isTrix: false);
      }
    }
    return const Text("");
  }
  */
}

class DropDown extends StatefulWidget {
  final List<int> possibilites;
  const DropDown({
    super.key,
    required this.possibilites,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int? currentValue;

  @override
  Widget build(BuildContext context) {
    print(currentValue);
    return DropdownButton<int>(
      value: currentValue,
      //items: calc(widget.isTrix),
      items: widget.possibilites.map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        );
      }).toList(),
      onChanged: (int? value) {
        setState(() {
          currentValue = value!;
        });
      },
    );
  }

  /*
  List<DropdownMenuItem<int>> calc(bool isTrix) {
    if (isTrix) {
      final possibleTrix = [150,200,250,300,350];
      return possibleTrix.map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        );
      }).toList();
    } else {
      final possibleOther = [for(int i=0;i<widget.number;i++) i];
      return possibleOther.map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        );
      }).toList();
    }
  }
  */
}
