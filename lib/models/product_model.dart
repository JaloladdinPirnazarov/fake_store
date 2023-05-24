import 'package:fake_store/models/rate_model.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  //final RateModel rate;

  ProductModel(
      this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      //this.rate
  );
}
