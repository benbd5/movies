import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/enum/type_enum.dart';
import 'package:movies_app/models/carousel_list.dart';

import 'background_image_opacity.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({
    super.key,
    required this.carouselList,
    required this.context,
  });

  final List<CarouselList> carouselList;
  final BuildContext context;

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> with TickerProviderStateMixin {
  late PageController backgroundPageController;
  late PageController foregroundPageController;
  late AnimationController timerController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    backgroundPageController = PageController(viewportFraction: 1.0, initialPage: 0);
    foregroundPageController = PageController(viewportFraction: 0.6, initialPage: 0);
    timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
      if (timerController.isCompleted) {
        if (activePage == widget.carouselList.length - 1) {
          backgroundPageController.jumpToPage(0);
          foregroundPageController.jumpToPage(0);
        } else {
          backgroundPageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
          );
          foregroundPageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
          );
        }
        timerController.reset();
        timerController.forward();
      }
    });
    timerController.forward();
  }

  @override
  void dispose() {
    backgroundPageController.dispose();
    foregroundPageController.dispose();
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320,
          child: Stack(
            children: [
              PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.carouselList.length,
                controller: backgroundPageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                    foregroundPageController.animateToPage(
                      page,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                    );
                    timerController.reset();
                    timerController.forward();
                  });
                },
                itemBuilder: (context, index) {
                  return BackgroundImageOpacity(
                    posterPath: widget.carouselList[index].posterPath,
                  );
                },
              ),
              PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.carouselList.length,
                controller: foregroundPageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                    backgroundPageController.animateToPage(
                      page,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                    );
                    timerController.reset();
                    timerController.forward();
                  });
                },
                itemBuilder: (context, index) {
                  bool active = index == activePage;
                  return slider(widget.carouselList, index, active);
                },
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(widget.carouselList.length, activePage),
        ),
      ],
    );
  }

  AnimatedBuilder slider(images, pagePosition, active) {
    Image image = Image(
      image: CachedNetworkImageProvider(images[pagePosition].posterPath),
      fit: BoxFit.cover,
    );

    precacheImage(image.image, context);

    return AnimatedBuilder(
      animation: foregroundPageController,
      builder: (context, child) {
      double value = 1;
        if (foregroundPageController.position.haveDimensions) {
          value = foregroundPageController.page! - pagePosition;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 320,
            width: Curves.easeInOut.transform(value) * 320,
            child: child,
          ),
        );
      },
      child:Transform.scale(
        scale: max(0.9, 1 - (15 - pagePosition).abs() * 0.3),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          margin: EdgeInsets.all(active ? 5 : 10),
          child:  InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                widget.carouselList[pagePosition].type == TypeEnum.tvShow ? '/tv_show_details' : '/movie_details',
                arguments: widget.carouselList[pagePosition].id,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: widget.carouselList[pagePosition].posterPath != null
                ? image :
                Container(
                  color: Colors.grey.withOpacity(0.25),
                  width: 150,
                  child: Icon(Icons.movie, color: Colors.white.withOpacity(0.9), size: 50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
