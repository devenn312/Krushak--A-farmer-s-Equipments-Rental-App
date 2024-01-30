import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krushak/provider/product_model.dart';
import 'package:krushak/provider/sign_in_provider.dart';
import 'package:show_loader_dialog/show_loader_dialog.dart';

class DataController extends GetxController{

final firebaseInstance = FirebaseFirestore.instance;
 
 void onReady(){
  super.onReady();
  getAllProduct();
 }

 List<Product> loginUserData = [];
 List<Product> allProduct = [];

Future<void> addNewProduct(Map productdata, File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    final ref =
        FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    //  CommonDialog.showLoader(true);
    print("Updated $response");
    
    var imageUrl = await ref.getDownloadURL();


  
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("User is not signed in");
    }
  var response = await firebaseInstance.collection('productlist').add({
    'product_name': productdata['p_name'],
    'product_model': productdata['p_model'],
    'product_year': productdata['p_year'],
    'product_price': productdata['p_price'],
    "product_upload_date": productdata['p_upload_date'],
    'product_image': imageUrl,
    'user_Id': currentUser.uid,
    "phone_number": productdata['phone_number'],
  });
  
  print("Firebase response1111 $response");
  
  // Show success pop-up
  
  Get.back();
} catch (exception) {
  print("Error Saving Data at firestore $exception");
}
    catch (exception) {
      // CommonDialog.showLoader(false);
      print("Error Saving Data at firestore $exception");
    }
  }

Future<void> getLoginUserProduct() async {
    print("loginUserData YEs $loginUserData");
    loginUserData = [];
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("User is not signed in");
    }
      CommonDialog.showLoader(true);
      final List<Product> lodadedProduct = [];
      var response = await firebaseInstance
          .collection('productlist')
          .where('user_Id', isEqualTo: currentUser.uid)
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            print("Product ID  ${result.id}");
            double productPrice;
try {
  productPrice = double.parse(result['product_price']);
} catch (e) {
  productPrice = 0.0; // or any other default value
}

int phoneNumber;
try {
  phoneNumber = int.parse(result['phone_number']);
} catch (e) {
  phoneNumber = 0; // or any other default value
}

double productYear;
try {
  productYear = double.parse(result['product_year']);
} catch (e) {
  productYear = 0.0; // or any other default value
}

double productModel;
try {
  productModel = double.parse(result['product_model']);
} catch (e) {
  productModel = 0.0; // or any other default value
}

lodadedProduct.add(
  Product(
    productId: result.id,
    userId: result['user_Id'],
    productname: result['product_name'],
    productprice: productPrice,
    productimage: result['product_image'],
    phonenumber: phoneNumber,
    productuploaddate: result['product_upload_date'].toString(),
    productyear: result['product_year'].toString(),
    productmodel: result['product_model'].toString(),
  ),
);
          },
        );
      }
      loginUserData.addAll(lodadedProduct);
      update();
      CommonDialog.showLoader(false);
      
    } on FirebaseException catch (e) {
     CommonDialog.showLoader(false);
      print("Error $e");
    } catch (error) {
      CommonDialog.showLoader(false);
      print("error $error");
    }
  }

Future<void> getAllProduct() async {
    allProduct = [];
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("User is not signed in");
    }
      CommonDialog.showLoader(true);
      final List<Product> lodadedProduct1 = [];
      var response = await firebaseInstance
          .collection('productlist')
          .where('user_Id', isNotEqualTo: currentUser.uid)
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            print(result.id);
double productPrice;
try {
  productPrice = double.parse(result['product_price']);
} catch (e) {
  productPrice = 0.0; // or any other default value
}

int phoneNumber;
try {
  phoneNumber = int.parse(result['phone_number']);
} catch (e) {
  phoneNumber = 0; // or any other default value
}

double productYear;
try {
  productYear = double.parse(result['product_year']);
} catch (e) {
  productYear = 0.0; // or any other default value
}

double productModel;
try {
  productModel = double.parse(result['product_model']);
} catch (e) {
  productModel = 0.0; // or any other default value
}

lodadedProduct1.add(
  Product(
    productId: result.id,
    userId: result['user_Id'],
    productname: result['product_name'],
    productprice: productPrice,
    productimage: result['product_image'],
    phonenumber: phoneNumber,
    productuploaddate: result['product_upload_date'].toString(),
    productyear: result['product_year'].toString(),
    productmodel: result['product_model'].toString(),
  ),
);
          },
        );
        allProduct.addAll(lodadedProduct1);
        update();
      }

      CommonDialog.showLoader(false);
    } on FirebaseException catch (e) {
      CommonDialog.showLoader(false);
      print("Error $e");
    } catch (error) {
      CommonDialog.showLoader(false);
      print("error $error");
    }
  }

Future editProduct(productId, price) async {
    print("Product Id  $productId");
    try {
      CommonDialog.showLoader(true);
      await firebaseInstance
          .collection("productlist")
          .doc(productId)
          .update({"product_price": price}).then((_) {
        CommonDialog.showLoader(false);
        getLoginUserProduct();
      });
    } catch (error) {
      CommonDialog.showLoader(false);
      CommonDialog.showLoader(false);

      print(error);
    }
  }

  Future deleteProduct(String productId) async {
    print("Product Iddd  $productId");
    try {
      CommonDialog.showLoader(true);
      await firebaseInstance
          .collection("productlist")
          .doc(productId)
          .delete()
          .then((_) {
        CommonDialog.showLoader(false);
        getLoginUserProduct();
      });
    } catch (error) {
     CommonDialog.showLoader(false);
      CommonDialog.showLoader(false);
      print(error);
    }
  }

}
