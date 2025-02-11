import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MobileLayout extends StatelessWidget {
  
  final Image imageWidget;
  final Widget dataWidget;

  const MobileLayout(
      {super.key, required this.imageWidget, required this.dataWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        children: [
          imageWidget.animate(onPlay: (controller) => controller.repeat()).shimmer(delay: 2000.ms, duration: 1000.ms),
          SizedBox(
            // width 80% of screen
            width: MediaQuery.of(context).size.width * 0.8,            
            child: dataWidget,
          )
        ],
      ),
    );
  }
}