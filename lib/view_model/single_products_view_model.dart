
import 'package:fake_store/models/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../services/http_service.dart';

class ProductViewModel extends ChangeNotifier{

  HttpService service = HttpService();
  bool isLoading = false;
  ProductModel? product;

  Future<void>getProduct(int id)async{
    isLoading = true;
    notifyListeners();
    product = await service.getSingleProduct(id);
    isLoading = false;
    notifyListeners();
  }


}