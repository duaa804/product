import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:product_with_bloc/core/model/handling.dart';
import 'package:product_with_bloc/core/model/product_model.dart';
import 'package:product_with_bloc/core/service/product_service.dart';
import 'package:product_with_bloc/feature/product/bloc/product_event.dart';
import 'package:product_with_bloc/feature/product/bloc/product_state.dart';

import '../../../core/connect/connection_internet.dart';

ProductServiceImp service = ProductServiceImp();

class ProductBloc extends Bloc<ProductEvent, ProductState> {
 // final ScrollController _scrollController = ScrollController();
  ProductBloc() : super(LoadingGetProduct()) {
    on<GetData>((event, emit) async {
      emit(LoadingGetProduct());

      List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      print('Connectivity result: $connectivityResult');
      if (connectivityResult.first == ConnectivityResult.mobile ||
          connectivityResult.first == ConnectivityResult.wifi) {
        print('true');
        // يوجد اتصال بالإنترنت
        ResultModel result = await service.getData();
        if (result is ListOf<ProductModel>) {
          print('Data fetched from server: ${result.data}');
          var box = await Hive.openBox<ProductModel>('products');
          await box.clear(); // مسح البيانات القديمة
          await box.addAll(result.data);
          print('Data added to Hive: ${box.values.toList()}');
          emit(SucessGetProduct(productModel: result.data));
        } else {
          emit(ErrorGetProduct());
        }
      } else {
        // CacheManager();
       var box = await Hive.openBox<ProductModel>('products');
        var products = box.values.toList();
        var firstFiveProducts = products.take(5).toList();
        print('Data fetched from Hive: $firstFiveProducts');
        if (products.isNotEmpty) {
          emit(SucessGetProduct(productModel:  firstFiveProducts));
        } else {
          emit(ErrorGetProduct());
        }
      }
    });
  }
}
