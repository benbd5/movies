import 'dart:math';

import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({
    super.key,
    required this.movies,
    required this.context,
  });

  final List<dynamic> movies;
  final BuildContext context;

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> with TickerProviderStateMixin {
  late PageController pageController;
  late AnimationController timerController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {
      });
      if (timerController.isCompleted) {
        if (activePage == widget.movies.length - 1) {
          pageController.jumpToPage(0);
        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
          );
        }
        timerController.reset();
        timerController.forward();
      }
    });
    pageController = PageController(viewportFraction: 0.6, initialPage: 0);
    timerController.forward();
  }

  @override
  void dispose() {
    pageController.dispose();
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            pageSnapping: true,
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
                timerController.reset();
                timerController.forward();
              });
            },
            itemBuilder: (context, index) {
              bool active = index == activePage;
              return slider(widget.movies, index, active);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(widget.movies.length, activePage),
        ),
      ],
    );
  }

  AnimatedBuilder slider(images, pagePosition, active) {
    return AnimatedBuilder(
    animation: pageController,
    builder: (context, child) {
      return Transform.scale(
        scale: max(0.9, 1 - (pageController.page! - pagePosition).abs() * 0.3),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          margin: EdgeInsets.all(active ? 5 : 10),
          child:  InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/movie_details',
                arguments: widget.movies[pagePosition].id,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: widget.movies[pagePosition].posterPath != null
                    ? Image.network(
                  widget.movies[pagePosition].posterPath!,
                  fit: BoxFit.fill,
                )
                    :
                Container(
                  color: Colors.grey.withOpacity(0.25),
                  width: 150,
                  child: Icon(Icons.movie, color: Colors.white.withOpacity(0.9), size: 50),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> indicators(int imagesLength, int currentIndex) {
    List<Widget> indicators = [];
    for (int i = 0; i < imagesLength; i++) {
      bool isActive = i == currentIndex;
      indicators.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 8,
          height: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                if (isActive)
                  LinearProgressIndicator(
                    value: timerController.value,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: Colors.grey,
                    minHeight: 8,
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return indicators;
  }
}
