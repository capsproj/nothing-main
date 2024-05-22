import 'package:flutter/material.dart';
import 'package:minmalecommerce/admin_pages/admin_components/admin_drawer.dart';
import 'package:minmalecommerce/admin_pages/admin_components/admin_product_tile.dart';
import 'package:minmalecommerce/models/product_model.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:minmalecommerce/models/shop_model.dart';
import 'package:minmalecommerce/utils/scroller.dart';
import 'package:minmalecommerce/utils/utils.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  Products({super.key});

  static String id = '/Products';
  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<Shop>(context);
    final List<Product> products =
        shop.shop; // Assuming shop is a list of products

    return Scaffold(
      appBar: AppBar(title: const Text('Products'), actions: []),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: AdminDrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: Utils.getScreenHeight(context) * 0.025,
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: Utils.getScreenHeight(context) * 0.015),
            child: Center(
              child: Text(
                " ",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
          ),
          ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: SizedBox(
              height: UniversalPlatform.isDesktop || UniversalPlatform.isWeb
                  ? Utils.getScreenHeight(context) > 500
                      ? Utils.getScreenHeight(context) * 0.80
                      : Utils.getScreenHeight(context) * 0.70
                  : Utils.getScreenHeight(context) * 0.68,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: Utils.getScreenWidth(context) * 0.03,
                    vertical: Utils.getScreenWidth(context) * 0.005),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return AdminProductTile(product: product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
