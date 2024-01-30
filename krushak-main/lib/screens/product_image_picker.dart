import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krushak/theme/change_language.dart';
import 'package:krushak/theme/app_translations.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ProductImagePicker extends StatefulWidget {
  
  final void Function(File pickedImage) getImageValue;
  ProductImagePicker(this.getImageValue);

  @override
  _ProductImagePickerState createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File? pickedImage;

  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        widget.getImageValue(pickedImage!);
      });
    }
    Navigator.pop(context);
    // widget.getImageValue(pickedImage!);

    // print('{$pickedImage.path}');
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'.tr),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'.tr),
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 100,
          height: 100,
          child: pickedImage != null
              ? Image.file(
                  pickedImage!,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  'https://static.thenounproject.com/png/2413564-200.png',
                  fit: BoxFit.cover,
                ),
        ),
        ElevatedButton(
          onPressed: () {
            _showPicker();
          },
          child: Text('Upload Image'.tr),
        ),
      ],
    );
  }
}
