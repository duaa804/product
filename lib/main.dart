
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_with_bloc/core/model/product_model.dart';
//import 'package:product_with_bloc/core/model/product_model.dart';
import 'package:product_with_bloc/core/model/product_model_adapter.dart';

import 'package:product_with_bloc/feature/product/view/page_product.dart';

void main()async {
  
await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
//var connectivityResult = await Connectivity().checkConnectivity();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProductPage(),);
  }
}

//اختبار تخزين البيانات
class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Hive.openBox<ProductModel>('products'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var box = Hive.box<ProductModel>('products');
            if (box.isEmpty) {
              return Center(child: Text('No products found'));
            } else {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final product = box.getAt(index) as ProductModel;
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                  );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
