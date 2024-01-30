import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:krushak/provider/data_controller.dart';
import 'package:krushak/screens/product_image_picker.dart';
import 'product_image_picker.dart';
import 'package:krushak/provider/data_controller.dart';
import 'package:krushak/theme/change_language.dart';
import 'package:krushak/theme/app_translations.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  DataController controller = Get.put(DataController());
  var _userImageFile;
  String? _selectedProduct;

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> productData = {
    "p_name": "",
    "p_model": "",
    "p_year": "",
    "p_price": "",
    "p_upload_date": DateTime.now().millisecondsSinceEpoch,
    "phone_number": ""
  };

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  addProduct() {
    if (_userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'upload product image'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );

      return;
    }

    print("image got $_userImageFile");

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is valid ".tr);

      print("Data for new product".tr + " $productData");

      controller.addNewProduct(productData, _userImageFile);
      showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Product Uploaded".tr),
                          content: new Text(
                              "Your product has been added".tr),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("OK".tr),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Product'.tr),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Product Name'.tr,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_name'] = value!;
                  },
                ),
// TextFormField(
//   decoration: InputDecoration(
//     labelText: 'Product Name',
//   ),
//   validator: (value) {
//     if (_selectedProduct == null || _selectedProduct!.isEmpty) {
//       return 'Product Name Required';
//     }
//     return null;
//   },
//   onSaved: (value) {
//     productData['p_name'] = _selectedProduct!;
//   },
//   builder: (FormFieldState<String?> state) {
//     return InputDecorator(
//       decoration: InputDecoration(
//         labelText: 'Product Name',
//         errorText: state.hasError ? state.errorText : null,
//         border: OutlineInputBorder(),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       child: DropdownButtonFormField<String>(
//         value: _selectedProduct,
//         onChanged: (value) {
//           setState(() {
//             _selectedProduct = value;
//           });
//         },
//         items: [
//           DropdownMenuItem(
//             value: 'Product 1',
//             child: Text('Product 1'),
//           ),
//           DropdownMenuItem(
//             value: 'Product 2',
//             child: Text('Product 2'),
//           ),
//           DropdownMenuItem(
//             value: 'Product 3',
//             child: Text('Product 3'),
//           ),
//         ],
//         decoration: InputDecoration.collapsed(hintText: ''),
//       ),
//     );
//   },
// ),

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Product Model'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Model Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_model'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Product Manufacturing Year'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Manufacturing Year Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_year'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Per Day Rent'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Per Day Rent';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_price'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Phone Number'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number  Required'.tr;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['phone_number'] = value!;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ProductImagePicker(_pickedImage),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    addProduct();
                  },
                  child: Text('Submit'.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
