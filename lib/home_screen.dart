import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    super.initState();

    // animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    // rotation animation
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // radius animation -> circle to square
    _radiusAnimation = Tween<double>(
      begin: 450.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final boxShadows1 = [
      const BoxShadow(
        color: Colors.black54,
        offset: Offset(-6, -6),
        blurRadius: 3,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        offset: const Offset(6, 6),
        blurRadius: 3,
      ),
    ];

    final boxShadows2 = [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        offset: const Offset(-6, -6),
        blurRadius: 3,
      ),
      const BoxShadow(
        color: Colors.black54,
        offset: Offset(6, 6),
        blurRadius: 3,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // biggest
                  Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Container(
                      width: 255,
                      height: 255,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[500],
                        borderRadius: BorderRadius.circular(
                          _radiusAnimation.value,
                        ),
                        boxShadow: boxShadows1,
                      ),
                    ),
                  ),
                  // 2nd biggest
                  Transform.rotate(
                    angle: _rotationAnimation.value + 0.2,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(
                          _radiusAnimation.value,
                        ),
                        boxShadow: boxShadows2,
                      ),
                    ),
                  ),
                  // 3rd biggest
                  Transform.rotate(
                    angle: _rotationAnimation.value + 0.4,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(
                          _radiusAnimation.value,
                        ),
                        boxShadow: boxShadows1,
                      ),
                    ),
                  ),
                  // 2nd biggest
                  Transform.rotate(
                    angle: _rotationAnimation.value + 0.6,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[600],
                        borderRadius: BorderRadius.circular(
                          _radiusAnimation.value,
                        ),
                      ),
                    ),
                  ),
                  // Smallest
                  Transform.rotate(
                    angle: _rotationAnimation.value + 0.8,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple[200],
                          borderRadius: BorderRadius.circular(
                            _radiusAnimation.value,
                          ),
                          boxShadow: boxShadows2),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
