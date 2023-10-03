import 'package:flutter/material.dart';

import 'animated_square.dart';
import 'fade_in.dart';
import 'spinner.dart';

// enum SquareSize { petit, grand }

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  // SquareSize currentSquareShape = SquareSize.grand;
  late AnimationController _controller;
  // late Animation<double> _curve;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.forward();

    // _curve = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    super.initState();
  }

  // void switchSquare() {
  //   setState(() {
  //     currentSquareShape == SquareSize.grand
  //         ? _controller.forward()
  //         : _controller.reverse();
  //     currentSquareShape = currentSquareShape == SquareSize.grand
  //         ? SquareSize.petit
  //         : SquareSize.grand;
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      alignment: Alignment.center,
      // child: Center(child: AnimatedSquar(animation: _controller))
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              animation: _controller,
              child: const Text('123'),
            ),
            const SizedBox(height: 200),
            const Spinner()
          ],
        ),
        // child: Spinner(),
      ),
    );
  }
}
