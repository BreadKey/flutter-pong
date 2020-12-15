part of game;

class Pong {
  final player = Player();
  final enemy = Player();

  void init() {
    player._score = 0;
    enemy._score = 0;

    player._position = table.centerLeft + Offset(playerSize.width / 2, 0);
    enemy._position = table.centerRight - Offset(playerSize.width / 2, 0);
  }
}
