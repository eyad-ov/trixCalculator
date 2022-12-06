import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trix/ads/ad_helper.dart';
import 'package:trix/views/game_view.dart';

class PlayersView extends StatefulWidget {
  const PlayersView({super.key});

  @override
  State<PlayersView> createState() => _PlayersViewState();
}

class _PlayersViewState extends State<PlayersView> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  int? log = 1;
  BannerAd? _bannerAd;
  bool loaded = false;

  @override
  void initState() {
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    super.initState();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId2,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            loaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {},
      ),
      request: const AdRequest(),
    );
    _bannerAd!.load();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
    _bannerAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Players"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
          TextField(
            controller: _controller1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Team1',
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          TextField(
            controller: _controller2,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Team2',
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Center(
            child: Text(
              "Which team should write down the result?",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text("Team1"),
                  leading: Radio<int>(
                    value: 1,
                    groupValue: log,
                    onChanged: (int? value) {
                      setState(() {
                        log = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text("Team2"),
                  leading: Radio<int>(
                    value: 2,
                    groupValue: log,
                    onChanged: (int? value) {
                      setState(() {
                        log = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          loaded
              ? Container(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  alignment: Alignment.center,
                  child: AdWidget(ad: _bannerAd!),
                )
              : const CircularProgressIndicator(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var team1 = _controller1.text;
          if (team1.isEmpty) {
            team1 = 'Team1';
          }
          var team2 = _controller2.text;
          if (team2.isEmpty) {
            team2 = 'Team2';
          }
          int team = log ?? 1;

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return GameView(team1: team1, team2: team2, team: team);
          }), (route) => false);
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}
