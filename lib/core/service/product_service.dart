//import 'package:hive/hive.dart';
//import 'package:product_with_bloc/core/connect/connection_internet.dart';
import 'package:product_with_bloc/core/model/handling.dart';
import 'package:product_with_bloc/core/model/product_model.dart';
import 'package:product_with_bloc/core/service/core_service.dart';
import 'package:dio/dio.dart';
//import 'package:product_with_bloc/feature/product/bloc/product_event.dart';
abstract class ProductService extends Service {
  String baseurl = 'https://freetestapi.com/api/v1/products';
  Future<ResultModel> getData();
}

 class ProductServiceImp extends ProductService {

      // ProductModel? productModel = null;
  @override
  Future<ResultModel> getData() async {
    try {
      print("hhhh");
      response = await dio.get(baseurl);
print('ghs');
      List<ProductModel> productModel = List.generate(
        response.data.length,
        (index) => ProductModel.fromMap(response.data),
      );
      //print(productModel);
      return ListOf(data: productModel);
    } on DioException catch(e){
     return ExceptionModel(message: e.error.toString());
    }
  }}
//   class ProductServiceImp extends ProductService {
//   @override
//   Future<ResultModel> getData() async {
//     try {
//       bool isConnected = await checkConnectivity();
//       if (isConnected) {
//         response = await dio.get(baseurl);
//         List<ProductModel> productModel = List.generate(
//           response.data.length,
//           (index) => ProductModel.fromMap(response.data[index]),
//         );

//         var box = await Hive.openBox<ProductModel>('products');
//         await box.clear();
//         await box.addAll(productModel);

//         return ListOf(data: productModel);
//       } else {
//         var box = await Hive.openBox<ProductModel>('products');
//         List<ProductModel> cachedProducts = box.values.take(5).toList();
//         return ListOf(data: cachedProducts);
//       }
//     } on DioException catch (e) {
//       return ExceptionModel(message: e.error.toString());
//     }
//   }
// }
