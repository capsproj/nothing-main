import 'package:flutter/material.dart';
import 'package:minmalecommerce/admin_pages/Transaction_list.dart';
import 'package:minmalecommerce/admin_pages/landing_page.dart';
import 'package:minmalecommerce/admin_pages/products.dart';
import 'package:minmalecommerce/components/my_list_tile.dart';
import 'package:minmalecommerce/pages/about_page.dart';
import 'package:minmalecommerce/pages/auth_page.dart';
import 'package:minmalecommerce/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AdminDrawer extends StatelessWidget {
  AdminDrawer({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  void signUserOut(BuildContext context) async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => AuthPage()), // Navigate to AuthPage
    );
  }

  @override
  Widget build(BuildContext context) {
    print("size drawer");
    print(Utils.getScreenWidth(context) * 0.2);
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer header: logo
              DrawerHeader(
                child: Image.asset(
                  'lib/images/logo.png',
                  height: 200,
                ),
              ),
              SizedBox(
                height: Utils.getScreenHeight(context) * 0.02,
              ),
              // shop tile
              MyListTile(
                text: "Home",
                icon: Icons.home,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );
                },
              ),
              MyListTile(
                text: "Products",
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Products()),
                  );
                },
              ),
              MyListTile(
                text: "Transaction List",
                icon: Icons.history,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TransactionListPage(), // Navigate to TransactionListPage
                    ),
                  );
                },
              ),
              //   MyListTile(
              //     text: "Settings",
              //     icon: Icons.settings,
              //     onTap: () {
              //       Navigator.pop(context);
              //       Navigator.of(context).push(
              //        MaterialPageRoute(builder: (context) => SettingsPage()),
              //      );
              //     },
              //   ),
              MyListTile(
                text: "About",
                icon: Icons.info,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Utils.getScreenHeight(context) * 0.02),
            child: MyListTile(
              text: "Log Out",
              icon: Icons.logout,
              onTap: () {
                signUserOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
