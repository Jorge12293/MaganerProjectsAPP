import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, required  this.height, required this.width, this.margin }) : super(key: key);

  final double height, width;
  final EdgeInsets? margin;
  final double defaultPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6.0),
      child:  Shimmer.fromColors(
        baseColor: const Color(0xFFE6E6E6),
        highlightColor: const Color(0XFFCDCDCD),
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(144, 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding))
          ),
          height: height,
          width: width,
        )
      ),
    );
  }
}