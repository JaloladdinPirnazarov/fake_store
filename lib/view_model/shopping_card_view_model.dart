
import 'package:fake_store/models/db_product_model.dart';
import 'package:fake_store/models/product_model.dart';
import 'package:fake_store/services/sqflite_service.dart';
import 'package:flutter/cupertino.dart';

import '../services/http_service.dart';

class ShoppingCardViewModel extends ChangeNotifier{

  HttpService httpService = HttpService();
  SqfLiteService sqfLiteService = SqfLiteService();
  bool isLoading = false;
  List<ProductModel> productsList = [];
  List<DbProductModel> fromDb = [];
  double totalCost = 0;


  Future<void>readProducts(int id)async{
    isLoading = true;
    notifyListeners();
    var result = await sqfLiteService.getItems();
    fromDb = result.map((e){
      return DbProductModel(e["product_id"], e["productId"]);
    }).toList();
    for(int i = 0;i < fromDb.length;i++){
      var item = await httpService.getSingleProduct(fromDb[i].productId);
      item.sqfId = fromDb[i].id;
      productsList.add(item);
    }
    isLoading = false;
    notifyListeners();
  }


}