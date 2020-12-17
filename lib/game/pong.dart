part of game;

class Pong with ChangeNotifier {
  final player = Player();
  final enemy = Player();

  static final _maxY = table.height - playerSize.height / 2;
  static final _minY = playerSize.height / 2;

  FrameGenerator _frameGenerator;
  StreamSubscription _frameSubscription;

  Offset _ballPosition;
  Offset get ballPosition => _ballPosition;
  Offset _ballVelocity;

  void init() {
    player._score = 0;
    enemy._score = 0;

    player._position = table.centerLeft + Offset(playerSize.width / 2, 0);
    enemy._position = table.centerRight - Offset(playerSize.width / 2, 0);
    _ballPosition =
        enemy.position + Offset(-playerSize.width / 2 - ballRadius, 0);
    _ballVelocity = Offset(-3, 0);
    _frameGenerator = DefaultFrameGenerator();
  }

  void _move(Player target, double step) {
    target._position += Offset(0, step);

    if (target._position.dy > _maxY) {
      target._position = Offset(target._position.dx, _maxY);
    } else if (target._position.dy < _minY) {
      target._position = Offset(target._position.dx, _minY);
    }
  }

  void start() {
    _frameSubscription?.cancel();
    _frameSubscription = _frameGenerator.frameStream.listen((_) {
      _update();
    });
  }

  void _update() {
    _updatePlayer();
    _updateEnemy();
    _updateBall();
    notifyListeners();
  }

  void _updatePlayer() {}

  double _enemyStep = 4;
  void _updateEnemy() {
    _move(enemy, _enemyStep);

    if (_enemyStep > 0 && enemy._position.dy == _maxY) {
      _enemyStep = -_enemyStep;
    } else if (_enemyStep < 0 && enemy._position.dy == _minY) {
      _enemyStep = -_enemyStep;
    }
  }

  void _updateBall() {
    _ballPosition += _ballVelocity;

    if (_ballVelocity.dx < 0) {
      if (_ballVelocity.dx < 0 && _isBallCollidedWith(player)) {
        _hitBallBy(player);
      }
    } else {
      if (_isBallCollidedWith(enemy)) {
        _hitBallBy(enemy);
      }
    }

    if (_isBallCollidedWithWall) {
      _ballVelocity = Offset(_ballVelocity.dx, -_ballVelocity.dy);
    }
  }

  bool _isBallCollidedWith(Player target) {
    return Rect.fromCenter(
            center: target.position,
            width: playerSize.width + ballRadius * 2,
            height: playerSize.height + ballRadius * 2)
        .contains(ballPosition);
  }

  bool get _isBallCollidedWithWall =>
      _ballPosition.dy < ballRadius ||
      _ballPosition.dy > table.height - ballRadius;

  void _hitBallBy(Player target) {
    _ballVelocity = Offset(-_ballVelocity.dx,
        _ballVelocity.dy + (_ballPosition.dy - target.position.dy) / 15);
  }

  void dispose() {
    super.dispose();
    _frameSubscription?.cancel();
  }
}
