import 'package:flutter/material.dart';

import '../../models/page_view_model.dart';

class OnBoardingItem extends StatelessWidget {
  final PageViewModel page;
  const OnBoardingItem(this.page);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: page.image,
        ),
        const SizedBox(height: 15.0,),
        Text(
          page.title,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.0
          ),
        ),
        const SizedBox(height: 15.0,),
        Text(
          page.body,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0
          ),
        ),
        const SizedBox(height: 50.0,),
      ],
    );
  }
}