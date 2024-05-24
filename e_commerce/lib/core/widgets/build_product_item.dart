import 'package:e_commerce/features/product%20view/presentation/ui/product_view_screen.dart';
import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../../features/products/models/product_model.dart';

class BuildProductItem extends StatelessWidget {
  final ProductModel product;
  const BuildProductItem({required this.product});

  @override
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
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 0.2,
                offset: const Offset(-3,3)
            )
          ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 150.0,
                  width: 150.0,
                  child: Image.network(
                      product.avatar,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, trace) => Image.asset('assets/images/splash.png',)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: mainColor.withOpacity(0.8)
                    ),
                    padding: const EdgeInsets.all(4.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Text(
                      '-${product.discount}%',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 20.0, left: 10.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 40.0,),

                    Row(
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}