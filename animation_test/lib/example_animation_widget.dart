import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ExampleAnimationWidget extends StatefulWidget {
  const ExampleAnimationWidget({super.key});

  @override
  State<ExampleAnimationWidget> createState() => _ExampleAnimationWidgetState();
}

class _ExampleAnimationWidgetState extends State<ExampleAnimationWidget>
    with TickerProviderStateMixin {
  Size containerSize = const Size(200, 200);
  Color containerColor = Colors.blue;
  String src =
      "https://images.unsplash.com/photo-1614102073832-030967418971?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80";
  Random random = Random();
  late AnimationController _controller;
  late Animation<Offset> slideTween;
  late Animation<double> rotateTween;
  late Animation<double> slide;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    slideTween = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(_controller);
    Timer.periodic(const Duration(seconds: 1), (_) {
      containerSize =
          Size(random.nextInt(200).toDouble(), random.nextInt(200).toDouble());
      containerColor = Color.fromRGBO(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        1,
      );
      setState(() {});
    });
    slide = Tween<double>(begin: -300.0, end: 300.0).animate(_controller);

    rotateTween = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller)
      ..addListener(
        () {
          setState(() {});
        },
      );

    _controller.repeat();
    // _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(slide.value, slide.value),
        child: Transform.rotate(
          angle: rotateTween.value,
          child: Container(
            width: containerSize.width,
            height: containerSize.height,
            color: containerColor,
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: SlideTransition(
  //       position: slideTween,
  //       child: Container(
  //         height: 150,
  //         width: 150,
  //         color: Colors.indigo,
  //       ),
  //     ),
  //   );
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: FadeTransition(
  //       opacity: _controller,
  //       child: Container(
  //         height: 300,
  //         width: 300,
  //         color: Colors.indigo,
  //       ),
  //     ),
  //   );
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     // child: Image.network(src, fit: BoxFit.cover),
  //     child: FadeInImage.assetNetwork(
  //       placeholder: 'images/placeholder.jpg',
  //       image: src,
  //       fit: BoxFit.cover,
  //       height: 300,
  //       width: double.infinity,
  //       fadeInCurve: Curves.easeInCubic,
  //     ),
  //   );
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: AnimatedContainer(
  //       width: containerSize.width,
  //       height: containerSize.height,
  //       duration: const Duration(seconds: 1),
  //       color: containerColor,
  //     ),
  //   );
  // }
}
