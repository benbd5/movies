import 'package:flutter/material.dart';

class ShimmerLoader extends StatefulWidget {
  const ShimmerLoader({super.key,});

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8),
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                      color: _isHighlighted ? Colors.grey.withOpacity(0.3) : Colors.grey.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 150,
                    child: Icon(Icons.movie, color: Colors.white.withOpacity(0.9), size: 50),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
