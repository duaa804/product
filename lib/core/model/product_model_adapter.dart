import 'package:hive/hive.dart';
import 'package:product_with_bloc/core/model/product_model.dart';

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    return ProductModel(
      name: reader.readString(),
      description: reader.readString(),
      image: reader.readString(),
      price: reader.readDouble(),
      brand: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.image);
    writer.writeDouble(obj.price.toDouble());
    writer.writeString(obj.brand);
  }
}
