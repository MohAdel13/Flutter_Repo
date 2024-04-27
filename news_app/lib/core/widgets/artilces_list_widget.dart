import 'package:flutter/material.dart';

import 'build_article_item.dart';

class ArticlesListWidget extends StatelessWidget {

  final List articles;
  ArticlesListWidget({required this.articles});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: ListView.separated(
        itemBuilder: (context, index) => BuildArticleItem(article: articles[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(color: Colors.grey, height: 1,),
        ),
        itemCount: articles.length,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
