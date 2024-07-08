// import 'package:connectivity_plus/connectivity_plus.dart';

// Future<bool> checkConnectivity() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
//     return true;
//   } else {
//     return false;
//   }
// }
import 'package:hive/hive.dart';
//import 'package:product_with_bloc/core/model/handling.dart';
import 'package:product_with_bloc/core/model/product_model.dart';

class CacheManager {
  static const int maxCacheSize = 5;

  Future<void> addToCache(ProductModel product) async {
    var box = await Hive.openBox<ProductModel>('products');
    if (box.length >= maxCacheSize) {
      box.deleteAt(0); // إزالة الأقدم إذا كان الكاش يحتوي على الحد الأقصى من العناصر
    }
    await box.add(product);
  }

  List<ProductModel> getCache() {
    var box = Hive.box<ProductModel>('products');
    return box.values.toList();
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:product_with_bloc/feature/product/bloc/product_bloc.dart';
// import 'package:product_with_bloc/feature/product/bloc/product_event.dart';
// import 'package:product_with_bloc/feature/product/bloc/product_state.dart';

// class ProductPage extends StatefulWidget {
//   const ProductPage({Key? key}) : super(key: key);

//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       // المستخدم قام بالتمرير إلى النهاية، قم بعرض البيانات الموجودة في الكاش
//       context.read<ProductBloc>().add(GetData());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductBloc()..add(GetData()),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Product Page')),
//         body: BlocBuilder<ProductBloc, ProductState>(
//           builder: (context, state) {
//             if (state is LoadingGetProduct) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is ErrorGetProduct) {
//               return Center(child: Text('There is no internet or no cached data'));
//             } else if (state is SucessGetProduct) {
//               return ListView.builder(
//                 controller: _scrollController,
//                 itemCount: state.productList.length,
//                 itemBuilder: (context, index) {
//                   final product = state.productList[index];
//                   return ListTile(
//                     title: Text(product.name),
//                     subtitle: Text(product.description),
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text('Unknown state'));
//             }
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
