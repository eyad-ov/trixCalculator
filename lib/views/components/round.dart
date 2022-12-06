import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trix/views/components/result_calculater.dart';

class Round extends StatefulWidget {
  final int num;
  final int kingdom;

  const Round({
    super.key,
    required this.num,
    required this.kingdom,
  });

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
  int? currentValue;
  List<int> possibilites = [];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(children: [
        Text("Round ${widget.num}"),
        const Text("     "),
        Consumer<ResultCalculater>(builder: (context, resultCalculater, child) {
          return DropdownButton<int>(
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
              });
              resultCalculater.changeResult(
                  (widget.kingdom - 1) * 5 + (widget.num - 1),
                  getResultOfRound());
            },
          );
        }),
      ]),
      leading: Image.asset(images[currentGame]),
      trailing: Column(children: [
        Consumer<ResultCalculater>(
          builder: (context, resultCalculater, child) {
            return TextButton(
              child: Icon(
                Icons.change_circle,
                color: Colors.green.shade300,
              ),
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
                });
                resultCalculater.changeResult(
                  (widget.kingdom - 1) * 5 + (widget.num - 1),
                  0,
                );
              },
            );
          },
        )
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
