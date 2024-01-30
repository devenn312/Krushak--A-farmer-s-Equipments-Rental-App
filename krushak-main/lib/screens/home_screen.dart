// ignore_for_file: deprecated_member_use

import 'package:avatar_glow/avatar_glow.dart';
import 'package:get/get.dart';
import 'package:krushak/provider/data_controller.dart';
import 'package:krushak/screens/addproduct_screen.dart';
import 'package:krushak/screens/login_screen.dart';
import 'package:krushak/screens/login_user_product_screen.dart';
import 'package:krushak/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:krushak/provider/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'help_screen.dart';
import 'language_screen.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'ChatRoom.dart';
import 'about_screen.dart';
import 'package:krushak/screens/login_user_product_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:krushak/theme/change_language.dart';
import 'package:krushak/theme/app_translations.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:krushak/screens/ChatScreen';

class HomeScreen extends StatefulWidget {
  final DataController controller = Get.put(DataController());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AboutScreen()));
  }

  void _navigateToNextScreen2(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HelpScreen()));
  }

  void _navigateToNextScreen3(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LanguageScreen()));
  }

  void _navigateToNextScreen5(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ChatScreen()));
  }

  void _navigateToNextScreen6(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddProductScreen()));
  }

  void _navigateToNextScreen7(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LoginUserProductScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("KRUSHAK"),
      ),
      body:
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Column(
          //     children: [
          //       TextField(
          //         // onChanged: (value) => _runFilter(value),
          //         decoration: InputDecoration(
          //           contentPadding:
          //               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          //           hintText: "Search",
          //           prefixIcon: IconButton(
          //             onPressed: () {
          //               print('search button pressed');
          //             },
          //             icon: Icon(Icons.search),
          //           ),
          //           suffixIcon: Container(
          //             width: 100,
          //             child: Row(
          //               children: [
          //                 IconButton(
          //                   onPressed: () {
          //                     print('add button pressed');
          //                   },
          //                   icon: Icon(Icons.stacked_bar_chart),
          //                 ),
          //                 IconButton(
          //                   onPressed: () {
          //                     print('mic button pressed');
          //                   },
          //                   icon: Icon(Icons.mic),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(20.0),
          //             borderSide: const BorderSide(),
          //           ),
          //         ),

          //       ),
          //     ],
          //   ),
          // ),
          GetBuilder<DataController>(
        builder: (controller) => controller.allProduct.isEmpty
            ? Center(
                child: Text(' NO DATA FOUND '),
              )
            : ListView.builder(
                itemCount: controller.allProduct.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Image.network(
                            controller.allProduct[index].productimage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Name".tr +
                                        " : ${controller.allProduct[index].productname}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Per Day Rent'.tr +
                                        ' : ${controller.allProduct[index].productprice}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Model'.tr +
                                        ' : ${controller.allProduct[index].productmodel}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Manufacturing Year'.tr +
                                        ' : ${controller.allProduct[index].productyear}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                child: ElevatedButton.icon(
                                  onPressed: () => {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()))
                                  },
                                  label: Text('CHAT'.tr),
                                  icon: Icon(Icons.chat),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Welcome".tr + "  ${sp.name}",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              accountEmail: Text(
                "${sp.email}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage("${sp.imageUrl}"),
                radius: 40,
              ),
            ),
            ListTile(
              title: Text("Account".tr),
              trailing: Icon(Icons.person),
              onTap: () {},
            ),
            ListTile(
              title: Text("My products".tr),
              trailing: Icon(Icons.car_rental),
              onTap: () {
                Navigator.of(context).pop();
                _navigateToNextScreen7(context);
              },
            ),
            ListTile(
              title: Text("Language".tr),
              trailing: Icon(Icons.language),
              onTap: () {
                _navigateToNextScreen3(context);
              },
            ),
            ListTile(
              title: Text("Help & Support".tr),
              trailing: Icon(Icons.phone),
              onTap: () {
                _navigateToNextScreen2(context);
              },
            ),
            ListTile(
              title: Text("About".tr),
              trailing: Icon(Icons.info),
              onTap: () {
                _navigateToNextScreen(context);
              },
            ),
            ListTile(
              title: Text("Sign Out".tr),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                sp.userSignOut();
                nextScreenReplace(context, const LoginScreen());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNextScreen5(context);
        },
        child: Icon(Icons.chat),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floating action button position to center

      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.blue,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: Text('Rent'.tr),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _navigateToNextScreen6(context);
              },
              child: Text('Lease'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
