
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_with_bloc/feature/product/bloc/product_bloc.dart';
import 'package:product_with_bloc/feature/product/bloc/product_event.dart';
import 'package:product_with_bloc/feature/product/bloc/product_state.dart';
import 'package:product_with_bloc/main.dart';
//import 'package:product_with_bloc/main.dart';

 class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetData()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(actions: [InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductList ()));
              },
              child: Icon(Icons.home))],),
           
            body: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is LoadingGetProduct) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ErrorGetProduct) {
                  return Center(child: Text('There is no internet'));
                } else if (state is SucessGetProduct) {
                  return ListView.builder(
                    itemCount: state.productModel.length,
                    itemBuilder: (context, index) {
                      final product = state.productModel[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text(product.description),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Unknown state'));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
