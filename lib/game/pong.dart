part of game;

class Pong {
  final _players = List.generate(2, (index) => Player(), growable: false);
  int get playerLength => _players.length;

  void init() {
    _players.forEach((player) {
      player._score = 0;
    });

    _players[userIndex]._position = table.centerLeft;
    _players[enemyIndex]._position = table.centerRight;
  }
}
