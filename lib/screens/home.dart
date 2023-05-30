import 'package:fake_store/others/widgets.dart';
import 'package:fake_store/screens/shopping_card.dart';
import 'package:fake_store/view_model/products_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/categories_model.dart';
import '../others/colors.dart';
import '../services/http_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widgets widgets = Widgets();
  HttpService service = HttpService();
  String category = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductsViewModel>(context, listen: false).getAllCategories().then((value){
        Provider.of<ProductsViewModel>(context, listen: false).setProducts(0);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          actions: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'),
              radius: 15,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          title: const Text("Fake store API"),
          centerTitle: true,
        ),
        body: Consumer<ProductsViewModel>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final categories = value.categories;
            final products = value.products;
            return  Container(
              height: MediaQuery.of(context).size.height,
              color: white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widgets.buildSearchField(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: widgets.buildBigTitle("Featured")),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: categories.length,
                          itemBuilder: (context, position) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  Provider.of<ProductsViewModel>(context, listen: false).setProducts(position);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text(
                                    categories[position].category,
                                    style: TextStyle(
                                        color: categories[position].isSelected
                                            ? Colors.black
                                            : Colors.grey,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: size.height / 2.2,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, position) {
                            return widgets.buildProductItem(products[position],
                                size.width / 2.2, size.height / 2.5, context);
                          }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: widgets.buildBottomNavigationBar(context),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
