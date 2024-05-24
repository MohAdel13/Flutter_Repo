import 'package:e_commerce/core/style/colors.dart';
import 'package:flutter/material.dart';
import '../ui/product_view_screen.dart';
import '../../../products/models/product_model.dart';

class BuildSimilarProductItem extends StatelessWidget{
  final ProductModel product;
  const BuildSimilarProductItem({required this.product});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductViewScreen(product))
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(-3,3),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 1,
              spreadRadius: 0.5,
            )
          ],
          borderRadius: BorderRadius.circular(30.0)
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  height: 200.0,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.network(
                    product.avatar,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, trace) => Image.asset('assets/images/splash.png')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: mainColor.withOpacity(0.8)
                    ),
                    padding: const EdgeInsets.all(4.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Text(
                      '-${product.discount.toString()}%',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    product.price.toString(),
                    style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    product.initialPrice.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}