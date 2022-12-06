import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Data/game.dart';

class TrixDataBase {
  TrixDataBase._privateConstructor();
  static final TrixDataBase instance = TrixDataBase._privateConstructor();

  //final StreamController<Game> _streamController = StreamController();

  Future<Database> getDB() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "Trix.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(''' 
        CREATE TABLE Games(
          id INTEGER PRIMARY KEY,
          team1 TEXT,
          team2 TEXT,
          numOfTeam INTEGER,
          year INTEGER,
          month INTEGER,
          day INTEGER,
          hour INTEGER,
          minute INTEGER,
          result INTEGER
        )
        ''');
      },
    );
  }

  /*
  Stream<Game> trixStream(){
    List<Game> games = await getAllGames();
    games.map((game) {_streamController.add(game);});
    return _streamController.stream;
  }*/

  Future<int> createGame(Game game) async {
    Database db = await getDB();
    return await db.insert("Games", {
      'team1': game.team1,
      'team2': game.team2,
      'numOfTeam': game.numOfTeam,
      'year': game.year,
      'month': game.month,
      'day': game.day,
      'hour': game.hour,
      'minute': game.minute,
      'result': game.result,
    });
  }

  Future<void> deleteGame(int id) async {
    Database db = await getDB();
    await db.delete(
      "Games",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close(Database db) async{
    await db.close();
  }

  Future<List<Game>> getAllGames() async {
    Database db = await getDB();
    final games =
        await db.query("Games", orderBy: "year DESC, month DESC, day DESC, hour DESC, minute DESC");
    if (games.isEmpty) {
      return [];
    }
    return games.map((row) {
      return Game.fromRow(row);
    }).toList();
  }
}
