import 'package:fake_store/models/categories_model.dart';
import 'package:fake_store/models/product_model.dart';
import 'package:fake_store/others/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class Widgets {
  Widget buildSearchField() {
    return Container(
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

  Widget buildProductItem(
      ProductModel productModel, double width, double height) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(15),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: starBackground,
                ),
                child: const Icon(Icons.star, color: Colors.white,size: 15,),
              )
            ],
          ),
          const SizedBox(height: 8,),
          Image.network(
            productModel.image,
            width: width,
            height: height / 2.5,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            productModel.title.length > 55
                ? ("${productModel.title.substring(0, 55)}...")
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
        ],
      ),
    );
  }
}
