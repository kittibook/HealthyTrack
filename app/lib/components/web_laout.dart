import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WebLayout extends StatelessWidget {
  
  final Image imageWidget;
  final Widget dataWidget;

  const WebLayout(
      {super.key, required this.imageWidget, required this.dataWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [imageWidget.animate(onPlay: (controller) => controller.repeat()).shimmer(delay: 2000.ms, duration: 1000.ms)],
                ),
              ),
              SizedBox(
                width: 400,
                child: dataWidget,
              )
            ],
          )
        ],
      ),
    );
  }
}