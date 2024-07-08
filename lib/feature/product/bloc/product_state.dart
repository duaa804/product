// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:product_with_bloc/core/model/product_model.dart';

class ProductState{}
final class ProductInitial extends ProductState{}

class SucessGetProduct extends ProductState {
  final List<ProductModel> productModel;

  SucessGetProduct({required this.productModel});
}

class ErrorGetProduct extends ProductState{}
class LoadingGetProduct extends ProductState{}
