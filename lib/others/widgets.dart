import 'package:fake_store/models/product_model.dart';
import 'package:fake_store/others/styles.dart';
import 'package:fake_store/screens/product_page.dart';
import 'package:fake_store/screens/shopping_card.dart';
import 'package:fake_store/services/http_service.dart';
import 'package:fake_store/services/sqflite_service.dart';
import 'package:fake_store/view_model/shopping_card_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

class Widgets {

  SqfLiteService sqfLiteService = SqfLiteService();

  Widget buildSearchField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: searchFieldColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        //border: InputBorder.none,
      ),
      child: const TextField(
        enabled: false,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            labelText: "Search",
            border: InputBorder.none),
      ),
    );
  }

  Widget buildBigTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: mainTitleStyle,
        )
      ],
    );
  }

  Widget buildProductItem(ProductModel productModel, double width,
      double height, BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            )
          ]),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProductPage(productId: productModel.id)));
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: starBackground,
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 15,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Image.network(
              productModel.image,
              width: width,
              height: height / 2.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              productModel.title.length > 30
                  ? ("${productModel.title.substring(0, 30)}...")
                  : productModel.title,
              style: mediumTitleStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "US \$ ${productModel.price}",
              style: priceTitleStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                await sqfLiteService.addItem(productModel.id);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  backgroundColor: textColor),
              child: const Text(
                "ADD TO CARD",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCardItem(ProductModel productModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProductPage(productId: productModel.id)));
        },
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Image.network(
                productModel.image,
                width: 70,
                height: 70,
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          productModel.title.length > 15
                              ? ("${productModel.title.substring(0, 15)}...")
                              : productModel.title,
                          style: title2),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.close, color: Colors.redAccent,))
                    ],
                  ),
                  Text(
                      productModel.title.length > 26
                          ? ("${productModel.title.substring(0, 26)}...")
                          : productModel.title,
                      style: descriptionStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("US \$${productModel.price}",
                          style: priceTitleStyle2),
                      Text(
                        "x1",
                        style: descriptionStyle,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCalculator(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: title2,
            ),
            Text(
              "US \$${context.read<ShoppingCardViewModel>().totalCost}",
              style: title2,
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: priceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                "CONFIRM ORDER",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              onPressed: () {},
            ))
          ],
        ),
      ],
    );
  }

  Widget buildTabBar(BuildContext context){
    return Container(
      height: 130,
      padding: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(50))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: navButtonColor,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(30))),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: InkWell(
                onTap: (){ Navigator.pop(context); },
                child: Row(
                  children: [
                    Icon(
                      Icons.house_outlined,
                      color: textColor,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            const Icon(
              Icons.star_border,
              color: Colors.grey,
            ),
            const Icon(
              Icons.notifications_none,
              color: Colors.grey,
            ),
            Container(
              decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  shape: BoxShape.rectangle),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context){
    return Container(
      height: 130,
      padding: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
          color: Colors.white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: navButtonColor,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(30))),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.house_outlined,
                    color: textColor,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            const Icon(
              Icons.star_border,
              color: Colors.grey,
            ),
            const Icon(
              Icons.notifications_none,
              color: Colors.grey,
            ),
            Container(
              decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  shape: BoxShape.rectangle),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ShoppingCard()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
