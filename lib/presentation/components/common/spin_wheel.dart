import 'dart:math';
import 'package:flutter/material.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key, required this.items, required this.onSpinEnd});
  final List<String> items;
  final ValueChanged<int> onSpinEnd; // Spin이 끝났을 때 선택된 인덱스를 전달하는 콜백

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedIndex = -1;
  double finalRotation = 0;

  // 제스처 관련 변수 추가
  double startDragY = 0;
  double _dragVelocity = 0;
  DateTime? _dragStartTime;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // 최대 지속시간을 10초로 설정
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  void _startSpin([double velocityMultiplier = 1.0]) {
    _selectedIndex = Random().nextInt(widget.items.length);
    final singleItemAngle = (2 * pi) / widget.items.length;

    // 속도에 따라 회전 수와 지속시간 조정
    const baseSpins = 5.0;
    final additionalSpins = (velocityMultiplier - 1.0) * 3; // 속도에 따라 추가 회전
    final totalSpins = baseSpins + additionalSpins;

    // 최소 4초, 최대 10초로 제한
    final duration = Duration(
        milliseconds:
            min(10000, max(4000, (4000.0 * velocityMultiplier).round())));

    final targetRotation = -(2 * pi * totalSpins +
        (_selectedIndex * singleItemAngle + singleItemAngle / 2));

    finalRotation = targetRotation;

    // 애니메이션 컨트롤러의 지속시간 업데이트
    _controller.duration = duration;

    _animation = Tween<double>(
      begin: 0,
      end: targetRotation,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(from: 0).then((_) {
      widget.onSpinEnd.call(_selectedIndex);
    });
  }

  void _handleDragStart(DragStartDetails details) {
    startDragY = details.localPosition.dy;
    _dragStartTime = DateTime.now();
    _dragVelocity = 0;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    // 드래그 중에는 아무 것도 하지 않음
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragStartTime == null) return;

    // 드래그 거리 계산
    final dragDistance = details.velocity.pixelsPerSecond.dy.abs();

    // 속도 계산 (픽셀/초)
    _dragVelocity = dragDistance;

    // 속도에 따른 배수 계산 (1.0 ~ 3.0 사이로 정규화)
    double velocityMultiplier = (_dragVelocity / 1000).clamp(1.0, 3.0);

    // 최소 속도 체크
    if (_dragVelocity > 100) {
      // 최소 속도 임계값
      _startSpin(velocityMultiplier);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _startSpin(1.0), // 탭하면 기본 속도로 회전
      onVerticalDragStart: _handleDragStart,
      onVerticalDragUpdate: _handleDragUpdate,
      onVerticalDragEnd: _handleDragEnd,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 고정된 화살표
          Positioned(
            top: 0,
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: const Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: Colors.red,
              ),
            ),
          ),
          // 회전하는 휠
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: child,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: CustomPaint(
                  painter: WheelPainter(items: widget.items),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<String> items;

  WheelPainter({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final angle = 2 * pi / items.length;

    for (int i = 0; i < items.length; i++) {
      paint.color = getColor(i);
      // 12시 방향에서 시작하도록 -pi/2 조정
      final startAngle = -pi / 2 + (i * angle);

      // 파이 조각 그리기
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height,
        ),
        startAngle,
        angle,
        true,
        paint,
      );

      // 경계선 그리기
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height,
        ),
        startAngle,
        angle,
        true,
        borderPaint,
      );

      // 텍스트 그리기
      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 2,
        textAlign: TextAlign.center,
      );
      textPainter.layout(
        maxWidth: size.width / 3,
      );

      // 텍스트 위치 및 회전 조정
      final radius = size.width * 0.35;
      final textAngle = startAngle + (angle / 2);
      final offset = Offset(
        size.width / 2 + radius * cos(textAngle) - textPainter.width / 2,
        size.height / 2 + radius * sin(textAngle) - textPainter.height / 2,
      );

      canvas.save();
      canvas.translate(offset.dx + textPainter.width / 2,
          offset.dy + textPainter.height / 2);
      canvas.rotate(textAngle + pi / 2);
      canvas.translate(-textPainter.width / 2, -textPainter.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(WheelPainter oldDelegate) => oldDelegate.items != items;

  Color getColor(int i) {
    final int res = i % 3;
    switch (res) {
      case 0:
        return Colors.green.shade200;
      case 1:
        return Colors.yellow.shade200;
      case 2:
        return Colors.orange.shade200;
      default:
        return Colors.blue.shade200;
    }
  }
}
