import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:krushak/theme/change_language.dart';
import 'package:krushak/theme/app_translations.dart';
import 'package:krushak/provider/data_controller.dart';

class LoginUserProductScreen extends StatelessWidget {
  DataController controller = Get.put(DataController());

// final editPriceValue = TextEditingController();

//   editProduct(productID, produtPrice) {
//     editPriceValue.text = produtPrice.toString();
//     Get.bottomSheet(
//       ClipRRect(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10.0),
//           topRight: Radius.circular(10.0),
//         ),
//         child: Container(
//           color: Colors.white,
//           height: 200,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(labelText: "Enter new price"),
//                   controller: editPriceValue,
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.back();
//                     controller.editProduct(productID, editPriceValue.text);
//                   },
//                   child: Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getLoginUserProduct();
    });

    return Scaffold(
      appBar: AppBar(title: Text("my product".tr)),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.loginUserData.isEmpty
            ? Center(
                child: Text('NO PRODUCT FOUND'.tr),
              )
            : ListView.builder(
                itemCount: controller.loginUserData.length,
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
                           controller.loginUserData[index].productimage,
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
                                    "Product Name:".tr+ " ${controller.loginUserData[index].productname}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rent Per Day:'.tr+ ' ${controller.loginUserData[index].productprice.toString()}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Model:'.tr+ ' ${controller.loginUserData[index].productyear.toString()}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Manufacturing year:'.tr + ' ${controller.loginUserData[index].productmodel.toString()}',
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
                              // ElevatedButton(
                              //   onPressed: () {
                              //      editProduct(controller.loginUserData[index].productId,controller.loginUserData[index].productprice);

                              //   },
                              //   child: Text('Edit'),
                              // ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.deleteProduct(controller.loginUserData[index].productId);
                                },
                                child: Text('Delete'.tr),
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
    );
  }
}
