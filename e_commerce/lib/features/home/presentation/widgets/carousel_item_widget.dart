import 'package:flutter/material.dart';

class CarouselItemWidget extends StatelessWidget {
  final String asset;
  const CarouselItemWidget(this.asset);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 7,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Image.asset(asset, fit: BoxFit.cover,),
      ),
    );
  }
}
