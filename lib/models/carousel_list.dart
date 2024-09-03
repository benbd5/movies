import 'package:yeez/enum/type_enum.dart';

class CarouselList {
  final int id;
  final String? posterPath;
  final TypeEnum type;
  final int length;

  CarouselList({
    required this.id,
    required this.posterPath,
    required this.type,
    required this.length,
  });

  factory CarouselList.fromDynamic(dynamic item) {
    return CarouselList(
      id: item.id,
      posterPath: item.posterPath,
      type: item.type,
      length: item.length,
    );
  }
}