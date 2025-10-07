import 'package:flutter/material.dart';

class SliderContent extends StatelessWidget {
  final String lyrics;
  final double fontSize;
  final Function()? onDoubleTap;
  final Function()? onLongPress;

  const SliderContent({
    super.key,
    required this.lyrics,
    required this.fontSize,
    this.onDoubleTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) { 
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          shadowColor: Colors.black,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                lyrics.replaceAll("#", "\n"),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SliderNumbers extends StatelessWidget {
  final String label;
  final double fontSize;

  const SliderNumbers({
    super.key,
    required this.label,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
