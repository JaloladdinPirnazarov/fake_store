import 'package:fake_store/view_model/single_products_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../others/colors.dart';
import '../others/styles.dart';

class ProductPage extends StatefulWidget {
  int productId;

  ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    context.read<ProductViewModel>().getProduct(widget.productId);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Индекс выбранной вкладки (можно изменить в соответствии с вашей логикой)
        onTap: (index) {
          // Обработчик события нажатия на вкладку
          // Здесь можно выполнять нужные вам действия при нажатии на вкладку
          // Например, обновлять состояние или навигироваться на другой экран
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Star',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Shop card',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("Product description"),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.jpg'),
            radius: 15,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<ProductViewModel>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (value.product != null) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Image.network(value.product!.image),
                    const SizedBox(height: 15,),
                    Text(
                      value.product!.title,
                      style: mediumTitleStyle,
                    ),
                    const SizedBox(height: 20,),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "US \$ ${value.product!.price} ",
                        style: priceTitleStyle,
                      ),
                      TextSpan(
                        text: value.product!.description,
                        style: const TextStyle(color: Colors.black54,fontSize: 18),
                      ),
                    ])),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          backgroundColor: textColor),
                      child: const Text(
                        "ADD TO CARD",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(
                    "Ooops something went wrong.\n Please check your internet connection\nand try again"),
              );
            }
          },
        ),
      ),
    );
  }
}
