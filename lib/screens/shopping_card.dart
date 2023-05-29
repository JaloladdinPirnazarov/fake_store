import 'package:fake_store/others/colors.dart';
import 'package:fake_store/view_model/shopping_card_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../others/styles.dart';
import '../others/widgets.dart';

class ShoppingCard extends StatefulWidget {
  const ShoppingCard({Key? key}) : super(key: key);

  @override
  State<ShoppingCard> createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  Widgets widgets = Widgets();

  @override
  void initState() {
    context.read<ShoppingCardViewModel>().readProducts(8);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      body: Consumer<ShoppingCardViewModel>(builder: (context, value, child) {
        if(value.isLoading){ return Center(child: CircularProgressIndicator()); }
        if(value.productsList.length != 0){
          return Column(
            children: [
              widgets.buildTabBar(context),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Card",
                            style: mainTitleWhiteStyle,
                          ),
                          Text("${value.productsList.length} items",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),

                      Container(
                          height: MediaQuery.of(context).size.height / 1.6,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: value.productsList.length,
                              itemBuilder: (context, position) {
                                return widgets.buildProductCardItem(
                                    value.productsList[position], context);
                              })),
                      widgets.buildCalculator(context),
                    ],
                  ))
            ],
          );
        }else{
          return Center(child: Text("Ooops something went wrong.\nPlease check your internet\nconnection and try again", style: title2),);
        }
      }),
    );
  }
}
