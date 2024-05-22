import 'package:flutter/material.dart';
import 'package:minmalecommerce/pages/TransactionHistory_user.dart';
import 'package:minmalecommerce/pages/about_page.dart';
import 'package:minmalecommerce/pages/cart_page.dart';
import 'package:minmalecommerce/pages/intro_page.dart';
import 'package:minmalecommerce/pages/settings_page.dart';
import 'package:minmalecommerce/pages/shop_page.dart';
import 'package:minmalecommerce/themes/theme_mode.dart';
import 'package:minmalecommerce/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class OnlineShop extends StatelessWidget {
  const OnlineShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: darkmode,
      routes: {
        IntroPage.id: (context) => const IntroPage(),
        ShopPage.id: (context) => ShopPage(),
        CartPage.id: (context) => const CartPage(),
        SettingsPage.id: (context) => const SettingsPage(),
        AboutPage.id: (context) => const AboutPage(),
        TransactionListPage.id: (context) =>
            TransactionListPage(), // Add this line
      },
    );
  }
}
