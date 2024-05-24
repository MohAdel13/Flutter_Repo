import 'package:e_commerce/features/home/models/category_model.dart';
import 'package:e_commerce/features/products/presentation/ui/products_screen.dart';
import 'package:flutter/material.dart';

class BuildCategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  const BuildCategoryItem(this.categoryModel);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductsScreen(category: categoryModel,))
        );
      },
      child: Container(
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(-3,3),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 0.2,
              spreadRadius: 1
            )
          ]
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(40.0),
                height: 150.0,
                width: 220.0,
                child: Image.network(
                  categoryModel.avatar,
                  errorBuilder: (context, error, tracer) => Image.asset('assets/images/splash.png'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(15.0),
                //color: Colors.grey.withOpacity(0.3),
                child: Text(
                  categoryModel.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
