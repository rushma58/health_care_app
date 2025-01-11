import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: -200,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(
                    200, 230, 201, 0.5), // Light green with opacity
              ),
            ),
          ),
          Positioned(
            top: -220,
            right: -90,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(
                    165, 214, 167, 0.4), // Slightly darker green with opacity
              ),
            ),
          ),
          // Content
          child,
        ],
      ),
    );
  }
}
