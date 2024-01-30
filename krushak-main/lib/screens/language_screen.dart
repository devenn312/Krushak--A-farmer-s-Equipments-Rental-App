import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krushak/theme/change_language.dart';
import 'package:krushak/theme/app_translations.dart';

import '../theme/storage.dart';

class Storage {
  static String readLanguageCode() {
    // Implement this method to read the saved language code from local storage.
    // For example, you could use the shared_preferences package.
    return 'en';
  }
}

void main() {
  runApp(LanguageScreen());
}

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _selectedLanguageCode;

  @override
  void initState() {
    super.initState();
    _selectedLanguageCode = Storage.readLanguageCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('KRUSHAK (language)')),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            ListTile(
              title: Text("English"),
              subtitle: Text("english"),
              leading: _buildLeadingIcon('en'),
              onTap: () {
                setState(() {
                  _selectedLanguageCode = 'en';
                });
                myController.changeLanguage('en', 'US');
              },
            ),
            ListTile(
              title: Text("हिंदी"),
              subtitle: Text("hindi"),
              leading: _buildLeadingIcon('hi'),
              onTap: () {
                setState(() {
                  _selectedLanguageCode = 'hi';
                });
                myController.changeLanguage('hi', 'IN');
              },
            ),
            ListTile(
              title: Text("मराठी"),
              subtitle: Text("marathi"),
              leading: _buildLeadingIcon('mr'),
              onTap: () {
                setState(() {
                  _selectedLanguageCode = 'mr';
                });
                myController.changeLanguage('mr', 'IN');
              },
            ),
          ],
        ));
  }

  Widget _buildLeadingIcon(String languageCode) {
  return IconButton(
    icon: Icon(
      _selectedLanguageCode == languageCode ? Icons.star : Icons.star_border,
    ),
    onPressed: () {
      setState(() {
        if (_selectedLanguageCode == languageCode) {
          _selectedLanguageCode = '';
        } else {
          _selectedLanguageCode = languageCode;
        }
      });
      if (_selectedLanguageCode.isNotEmpty) {
        myController.changeLanguage(_selectedLanguageCode, 'IN');
      }
    },
  );
}
}
