import 'package:flutter/material.dart';
import '../../../../core/style/colors.dart';
import '../../../products/models/product_model.dart';
import '../widgets/similar_products_widget.dart';

class ProductViewScreen extends StatelessWidget {
  final ProductModel product;
  const ProductViewScreen(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 310,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      product.avatar,
                      errorBuilder: (context, error, tracer) => Image.asset('assets/images/product.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        onPressed: () {  },
                        child: Image.asset('assets/images/favourite.png'),
                      ),
                    ),
                  )
                ],
              ),
            ),
        
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                                product.name,
                                style: const TextStyle(color: Colors.black, fontSize: 20.0),)
                          ),
                          const SizedBox(width: 40.0,),
                          Column(
                            children: [
                              Text(
                                product.initialPrice.toString(),
                                style: const TextStyle(
                                    color: Colors.grey, decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.grey,
                                    fontSize: 18.0
                                ),
                              ),
                              Text(
                                product.price.toString(),
                                style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 20.0),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                      Text(
                        product.description,
                        style: const TextStyle(color: Colors.grey),
                      ),
        
                      SimilarProductsWidget(product)
                    ],
                  ),
                ),
              ),
            ),
        
            //const Spacer(),
        
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(20.0)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: MaterialButton(
                onPressed: (){},
                child: const Text(
                  'Add To Cart',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
