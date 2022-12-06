import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trix/crud/crud.dart';
import 'package:trix/views/players_view.dart';
import '../Data/game.dart';
import '../ads/ad_helper.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trix Game"),
      ),
      body: FutureBuilder<List<Game>>(
        future: TrixDataBase.instance.getAllGames(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("loading..."));
          }
          List<Game> games = snapshot.data!;
          if (games.isEmpty) {
            return const Center(child: Text("No games yet."));
          }
          int index = 0;
          List<Widget> widgets = games.map((game) {
            if (index % 10 == 0) {
              index++;
              BannerAd bannerAd = getNewBannerAd();
              return Column(
                children: [
                  Container(
                    width: bannerAd.size.width.toDouble(),
                    height: bannerAd.size.height.toDouble(),
                    alignment: Alignment.center,
                    child: AdWidget(ad: bannerAd),
                  ),
                  generateCardFromGame(game),
                ],
              );
            } else {
              index++;
              return generateCardFromGame(game);
            }
          }).toList();
          return ListView(children: widgets);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const PlayersView();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget generateCardFromGame(Game game) {
    int res = game.result;
    Color listTileColor = Colors.green.shade100;
    if (res > 0) {
      listTileColor = Colors.blue.shade100;
    }
    if (res < 0) {
      listTileColor = Colors.red.shade100;
    }
    String hour = game.hour < 10 ? "0${game.hour}" : game.hour.toString();
    String minute =
        game.minute < 10 ? "0${game.minute}" : game.minute.toString();
    String team1Res = game.numOfTeam == 1 ? "${game.result}" : "-";
    String team2Res = game.numOfTeam == 2 ? "${game.result}" : "-";
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.lightBlue,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        tileColor: listTileColor,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${game.team1}:"),
                Text(team1Res),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${game.team2}:"),
                Text(team2Res),
              ],
            ),
          ],
        ),
        subtitle: Text(
          "$hour:$minute ${game.day}/${game.month}/${game.year}",
        ),
        trailing: TextButton(
          onPressed: () async {
            await TrixDataBase.instance.deleteGame(game.id!);
            setState(() {});
          },
          child: const Icon(Icons.delete),
        ),
      ),
    );
  }

  BannerAd getNewBannerAd() {
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (_) {},
        onAdFailedToLoad: (ad, error) {},
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
    return bannerAd;
  }
}
