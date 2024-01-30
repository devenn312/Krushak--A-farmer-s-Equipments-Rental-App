import 'package:flutter/material.dart';
import 'package:krushak/theme/change_language.dart';
import 'package:krushak/theme/app_translations.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
void main() {
  runApp(HelpScreen());
}

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('KRUSHAK (help)'.tr)),
      body: 
 ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        ListTile( title: Text("Email Support"),subtitle: Text("krushaksupport@gmail.com"),leading: Icon(Icons.email)),
        ListTile( title: Text("Phone Support"),subtitle: Text("9999999999"), leading: Icon(Icons.phone)),
        ListTile( title: Text("Web Support"),subtitle: Text("krushak.com"), leading: Icon(Icons.web))
      ],
    )
    );
  }
}