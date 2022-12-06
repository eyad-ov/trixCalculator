class Game {
  final int? id;
  final String team1;
  final String team2; 
  final int numOfTeam;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final int result;

  Game({
    required this.id,
    required this.team1,
    required this.team2,
    required this.numOfTeam,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.result,
  });

  factory Game.fromRow(Map<String, dynamic> row) {
    return Game(
      id: row['id'],
      team1: row['team1'],
      team2: row['team2'],
      numOfTeam: row['numOfTeam'],
      year: row['year'],
      month: row['month'],
      day: row['day'],
      hour: row['hour'],
      minute: row['minute'],
      result: row['result'],
    );
  }
}
