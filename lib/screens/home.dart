import 'package:fake_store/others/widgets.dart';
import 'package:fake_store/providers/provider.dart';
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
      Provider.of<AppProvider>(context, listen: false).getAllCategories().then((value){
        Provider.of<AppProvider>(context, listen: false).setProducts(0);
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
          actions: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'),
              radius: 15,
            ),
            SizedBox(
              width: 20,
            )
          ],
          title: const Text("Fake store API"),
          centerTitle: true,
        ),
        body: Consumer<AppProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final categories = value.categories;
            final products = value.products;
            return Container(
              padding: const EdgeInsets.all(20),
              color: white,
              child: Column(
                children: [
                  widgets.buildSearchField(),
                  const SizedBox(
                    height: 20,
                  ),
                  widgets.buildBigTitle("Featured"),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 55,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, position) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                Provider.of<AppProvider>(context, listen: false).setProducts(position);
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
                  SizedBox(
                    height: size.height / 2,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, position) {
                          return widgets.buildProductItem(products[position],
                              size.width / 2, size.height / 2.5);
                        }),
                  )
                ],
              ),
            );
          },
        ));
  }
}
