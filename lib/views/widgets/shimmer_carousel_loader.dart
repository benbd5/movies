import 'package:flutter/material.dart';

class ShimmerCarouselLoader extends StatefulWidget {
  const ShimmerCarouselLoader({super.key});

  @override
  State<ShimmerCarouselLoader> createState() => _ShimmerCarouselLoaderState();
}

class _ShimmerCarouselLoaderState extends State<ShimmerCarouselLoader> {
  bool _isHighlighted = false;

  @override
  void initState() {
    super.initState();
    _startColorTransition();
  }

  void _startColorTransition() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isHighlighted = !_isHighlighted;
        });
        _startColorTransition();
      }
    });
  }

  Widget _buildContainer(int index) {
    double width = index == 1 || index == 2 ? 230 : 100;
    EdgeInsetsGeometry padding = index == 0 || index == 1 ?
      const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20) :
      const EdgeInsets.only(left: 20, right: 20, top: 55, bottom: 55);
    Color color = index == 0 ? Colors.transparent : (_isHighlighted ? Colors.grey.withOpacity(0.3) : Colors.grey.withOpacity(0.15));
    Icon? icon = index == 0 ? null : Icon(Icons.movie, color: Colors.white.withOpacity(0.9), size: 50);

    return Container(
      padding: padding,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => _buildContainer(index),
      ),
    );
  }
}
