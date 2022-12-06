import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trix/views/components/result_calculater.dart';
import 'package:trix/views/components/round.dart';

class Kingdom extends StatefulWidget {
  final int kingdomNumber;
  const Kingdom({super.key, required this.kingdomNumber});

  @override
  State<Kingdom> createState() => _KingdomState();
}

class _KingdomState extends State<Kingdom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Round(
          num: 1,
          kingdom: widget.kingdomNumber,
        ),
        const SizedBox(
          height: 10,
        ),
        Round(
          num: 2,
          kingdom: widget.kingdomNumber,
        ),
        const SizedBox(
          height: 10,
        ),
        Round(
          num: 3,
          kingdom: widget.kingdomNumber,
        ),
        const SizedBox(
          height: 10,
        ),
        Round(
          num: 4,
          kingdom: widget.kingdomNumber,
        ),
        const SizedBox(
          height: 10,
        ),
        Round(
          num: 5,
          kingdom: widget.kingdomNumber,
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<ResultCalculater>(builder: (context, resultCalculater, child) {
          return Text(
            "Kingdom ${widget.kingdomNumber}:  ${resultCalculater.calculateResultOfKingdom(widget.kingdomNumber)}",
            style: TextStyle(
              color: Colors.blue.shade300,
              fontSize: 15,
            ),
          );
        }),
        Consumer<ResultCalculater>(
          builder: (context, resultCalculater, child) {
            return Text(
              "Game's result: ${resultCalculater.calculateResultOfGame()}",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 17,
              ),
            );
          },
        ),
      ],
    );
  }
}
