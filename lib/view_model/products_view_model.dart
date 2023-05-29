
import 'package:fake_store/models/categories_model.dart';
import 'package:fake_store/models/product_model.dart';
import 'package:fake_store/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class ProductsViewModel extends ChangeNotifier{
  HttpService service = HttpService();
  bool isLoading = false;
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> setProducts(int position)async{
    for (int i = 0; i < categories.length; i++) {
      categories[i].isSelected =
      i == position ? true : false;
    }
  getProducts(HttpService().categoryProductsRoute + categories[position].category).then((value){
    notifyListeners();
  });
  }

  Future<void> getAllCategories() async{
    isLoading = true;
    notifyListeners();
    final response = await service.getCategories();
    _categories = response;
    categories.insert(0, CategoryModel("All", true));
    isLoading = false;
    notifyListeners();
  }

  Future<void> getProducts(String route) async {
    isLoading = true;
    notifyListeners();
    final response = await service.getProducts(route);
    _products = response;
    isLoading = false;
    notifyListeners();
  }
}