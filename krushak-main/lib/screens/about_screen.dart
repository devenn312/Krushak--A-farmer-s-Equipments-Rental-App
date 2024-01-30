import 'package:flutter/material.dart';
import 'package:krushak/theme/change_language.dart';
import 'package:krushak/theme/app_translations.dart';
import 'package:krushak/provider/data_controller.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

void main() {
  runApp(AboutScreen());
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KRUSHAK (about)')),
      body: 
 ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        ListTile( title: Text("App Version"),subtitle: Text("0.0.1"),leading: Icon(Icons.info_rounded)),
        ListTile( title: Text("Developer"),subtitle: Text("Shaad Shaikh"), leading: Icon(Icons.person)),
        ListTile( title: Text("Developer"),subtitle: Text("Vansh Shah"), leading: Icon(Icons.person)),
        ListTile( title: Text("Developer"),subtitle: Text("Deven Randive"), leading: Icon(Icons.person))
      ],
    )
    );
  }
}
