import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/article/presentation/article_screen.dart';

class BuildArticleItem extends StatelessWidget{
  final Map article;
  const BuildArticleItem({required this.article});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=> ArticleScreen(uri: article['url'])
          )
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            ConditionalBuilder(
              condition: article['urlToImage'] != null,
              builder: (context) => Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(article['urlToImage'],),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              fallback: null,
            ),
            const SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    article['title'],
                    style: Theme.of(context).textTheme.headline1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    article['publishedAt'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}