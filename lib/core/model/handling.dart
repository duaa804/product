// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultModel{}
class ErrorModel extends ResultModel {
  String message;
  ErrorModel({
    required this.message,
  });
}
class ExceptionModel extends ResultModel {
  String message;
  ExceptionModel({
    required this.message,
  });
}

class ListOf<ProductModel> extends ResultModel {
  List<ProductModel> data;
  ListOf({
    required this.data,
  });
}


class SuccesModel extends ResultModel {
  String message;
  SuccesModel({
    required this.message,
  });
}
