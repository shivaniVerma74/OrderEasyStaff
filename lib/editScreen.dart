// import 'dart:io';
//
// import 'package:eshopmultivendor/Helper/AppBtn.dart';
// import 'package:eshopmultivendor/Helper/Color.dart';
// import 'package:eshopmultivendor/Helper/Session.dart';
// import 'package:eshopmultivendor/Helper/String.dart';
// import 'package:eshopmultivendor/Model/Attribute%20Models/AttributeModel/AttributesModel.dart';
// import 'package:eshopmultivendor/Model/Attribute%20Models/AttributeValueModel/AttributeValue.dart';
// import 'package:eshopmultivendor/Model/CategoryModel/categoryModel.dart';
// import 'package:eshopmultivendor/Model/ProductModel/Product.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
// class EditProduct extends StatefulWidget {
//   Product prod_detail;
//   EditProduct({Key? key, required this.prod_detail}) : super(key: key);
//
//   @override
//   State<EditProduct> createState() => _EditProductState();
// }
//
// class _EditProductState extends State<EditProduct> {
//   FocusNode? productFocus= FocusNode();
//   FocusNode? sortDescriptionFocus= FocusNode();
//   TextEditingController productNameControlller = TextEditingController();
//   String? productName;
//   String? sortDescription;
//   String? selectedCatName;
//   String? selectedCatID;
//   List<CategoryModel> catagorylist = [];
//   String? description;
//   late File imgFile;
//   late File imgFile2;
//   final imgPicker = ImagePicker();
//   final imgPicker2 = ImagePicker();
//   var selectedimage;
//   var selectedimage2;
//   int curSelPos = 0;
//   bool simpleProductSaveSettings = false;
//   bool variantProductProductLevelSaveSettings = false;
//   bool variantProductVariableLevelSaveSettings = false;
//   late StateSetter taxesState;
//   Animation? buttonSqueezeanimation;
//   AnimationController? buttonController;
//   List<bool> variationBoolList = [];
//   List<AttributeModel> attributesList = [];
//   late Map<String, List<AttributeValueModel>> selectedAttributeValues = {};
//   List<TextEditingController> _attrController = [];
//   bool _isNetworkAvail = true;
//   String? productType;
//
//
//   ///image picker
//   void _image_camera_dialog(BuildContext context) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => CupertinoActionSheet(
//         title: Text(
//           'Select an Image',
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54),
//         ),
//         actions: <CupertinoActionSheetAction>[
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 openGallery();
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Select a photo from Gallery',
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//               )),
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 openCamera();
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Take a photo with the camera',
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//               )),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           isDestructiveAction: true,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
//         ),
//       ),
//     );
//   }
//
//   void openCamera() async {
//     var imgCamera = await imgPicker.getImage(source: ImageSource.camera);
//     setState(() {
//       imgFile = File(imgCamera!.path);
//       selectedimage = imgFile;
//       print('image upload camera${imgFile} $selectedimage');
//     });
//   }
//
//   void openGallery() async {
//     var imgGallery = await imgPicker.getImage(source: ImageSource.gallery);
//     setState(() {
//       imgFile = File(imgGallery!.path);
//       selectedimage = imgFile;
//       print('image upload$imgFile $selectedimage');
//     });
//   }
//
//   void _image_camera_dialog2(BuildContext context) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => CupertinoActionSheet(
//         title: Text(
//           'Select an Image',
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54),
//         ),
//         actions: <CupertinoActionSheetAction>[
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 openGallery2();
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Select a photo from Gallery',
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//               )),
//           CupertinoActionSheetAction(
//               onPressed: () {
//                 openCamera2();
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Take a photo with the camera',
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//               )),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           isDestructiveAction: true,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
//         ),
//       ),
//     );
//   }
//
//   void openCamera2() async {
//     var imgCamera = await imgPicker2.getImage(source: ImageSource.camera);
//     setState(() {
//       imgFile2 = File(imgCamera!.path);
//       selectedimage2 = imgFile2 ;
//       print('image upload camera${imgFile2} $selectedimage2');
//     });
//   }
//
//   void openGallery2() async {
//     var imgGallery = await imgPicker2.getImage(source: ImageSource.gallery);
//     setState(() {
//       imgFile2 = File(imgGallery!.path);
//       selectedimage2 = imgFile2;
//       print('image upload$imgFile2 $selectedimage2');
//     });
//   }
//   ///--------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: getAppBar("Edit Product", context,),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                 right: 10,
//                 left: 10,
//                 top: 15,
//               ),
//               child: Text(
//                 getTranslated(context, "PRODUCTNAME_LBL")!,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: black,
//                 ),
//               ),
//             ),
//             Container(
//               width: width,
//               padding: EdgeInsets.only(
//                 left: 10,
//                 right: 10,
//               ),
//               child: TextFormField(
//                 onFieldSubmitted: (v) {
//                   FocusScope.of(context).requestFocus(productFocus);
//                 },
//                 focusNode: productFocus,
//                 keyboardType: TextInputType.text,
//                 style: TextStyle(
//                   color: fontColor,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 controller: productNameControlller,
//                 textInputAction: TextInputAction.next,
//                 inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
//                 onChanged: (value) {
//                   productName = value;
//                 },
//                 validator: (val) => validateProduct(val, context),
//                 decoration: InputDecoration(
//                   hintText: getTranslated(context, "PRODUCTHINT_TXT")!,
//                   hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.normal,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 5,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     getTranslated(context, "ShortDescription")!,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: black,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 05,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: lightBlack,
//                         width: 1,
//                       ),
//                     ),
//                     width: width,
//                     height: height * 0.12,
//                     child: Padding(
//                       padding:  EdgeInsets.only(
//                         left: 8,
//                         right: 8,
//                       ),
//                       child: TextFormField(
//                         initialValue: sortDescription,
//                         onFieldSubmitted: (v) {
//                           FocusScope.of(context).requestFocus(sortDescriptionFocus);
//                         },
//                         focusNode: sortDescriptionFocus,
//                         textInputAction: TextInputAction.newline,
//                         keyboardType: TextInputType.multiline,
//                         validator: (val) => sortdescriptionvalidate(val, context),
//                         onChanged: (value) {
//                           sortDescription = value;
//                         },
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintStyle: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 14,
//                           ),
//                           hintText: getTranslated(
//                               context, "Add Sort Detail of Product ...!")!,
//                         ),
//                         minLines: null,
//                         maxLines: null,
//                         // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
//                         expands:
//                         true, // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           getTranslated(context, "selected category")! + " :",
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4),
//                               color: Colors.grey[400],
//                               border: Border.all(color: black)),
//                           width: 200,
//                           height: 20,
//                           child: Center(
//                             child: selectedCatName == null
//                                 ? Text(
//                               getTranslated(context, "Not Selected Yet ...")!,
//                             )
//                                 : Text(selectedCatName!),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4),
//                       color: lightWhite1,
//                       border: Border.all(color: black),
//                     ),
//                     height: 200,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           ListView.builder(
//                             shrinkWrap: true,
//                             padding: EdgeInsetsDirectional.only(
//                                 bottom: 5, start: 10, end: 10),
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: catagorylist.length,
//                             itemBuilder: (context, index) {
//                               CategoryModel? item;
//
//                               item = catagorylist.isEmpty ? null : catagorylist[index];
//
//                               return item == null ? Container() : getCategorys(index);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//             mainImage(),
//             selectedMainImageShow(),
//             otherImages("other", 0), //only API panding
//             uploadedOtherImageShow(),
//             longDescription(),
//             additionalInfo(),
//             SizedBox(height: 10,),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 15),
//              child: Container(
//                height: 50,
//                width: MediaQuery.of(context).size.width,
//                decoration: BoxDecoration(
//                  color: primary,
//                  borderRadius: BorderRadius.circular(10)
//                ),
//                child: Center(child: Text(getTranslated(context, 'SEND_LBL').toString(),
//                  style: TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 16),)),
//              ),
//            )
//           ],
//         ),
//       ),
//     );
//   }
//
//   // void validateAndSubmit() async {
//   //   print("working here now ");
//   //   List<String> attributeIds = [];
//   //   List<String> attributesValuesIds = [];
//   //
//   //   for (var i = 0; i < variationBoolList.length; i++) {
//   //     if (variationBoolList[i]) {
//   //       final attributes = attributesList
//   //           .where((element) => element.name == _attrController[i].text)
//   //           .toList();
//   //       if (attributes.isNotEmpty) {
//   //         attributeIds.add(attributes.first.id!);
//   //       }
//   //     }
//   //   }
//   //   attributeIds.forEach((key) {
//   //     selectedAttributeValues[key]!.forEach((element) {
//   //       attributesValuesIds.add(element.id!);
//   //     });
//   //   });
//   //
//   //   //  if (validateAndSave()) {
//   //   print("yes here ");
//   //   _playAnimation();
//   //   editProductAPI(attributesValuesIds);
//   //   //  }
//   // }
//   // Future<void> editProductAPI(List<String> attributesValuesIds) async {
//   //   print("now here working again ");
//   //   _isNetworkAvail = await isNetworkAvailable();
//   //   if (_isNetworkAvail) {
//   //     try {
//   //       var request = http.MultipartRequest("POST", addProductsApi);
//   //       request.headers.addAll(headers);
//   //       request.fields["edit_product_id"] = model!.id!;
//   //       for(var v=0;v<model!.variants!.length;v++){
//   //         varId.add(model!.variants![v].id!);
//   //       }
//   //       request.fields["edit_variant_id"] = varId.join(",");
//   //       request.fields[SellerId] = CUR_USERID!;
//   //       request.fields[ProInputName] = productNameControlller.text;
//   //       request.fields[ProductTotalStock] = simpleProductTotalStock.text;
//   //       request.fields[ShortDescription] = sortDescription!;
//   //       // if (tagsControlller.text != "") request.fields[Tags] = tagsControlller.text;
//   //       // if (taxId != null) request.fields[ProInputTax] = taxId!;
//   //       // if (indicatorValue != null) request.fields[Indicator] = indicatorValue!;
//   //       // if (madeInControlller.text != "") request.fields[MadeIn] = madeInControlller.text;
//   //       // request.fields[TotalAllowedQuantity] = totalAllowController.text;
//   //       // request.fields[MinimumOrderQuantity] = minOrderQuantityControlller.text;
//   //       // request.fields[QuantityStepSize] = quantityStepSizeControlller.text;
//   //       // if (warrantyPeriodController.text != "")
//   //       //   request.fields[WarrantyPeriod] = warrantyPeriodController.text;
//   //       // if (guaranteePeriodController.text != "")
//   //       //   request.fields[GuaranteePeriod] = guaranteePeriodController.text;
//   //       // request.fields[DeliverableType] = deliverabletypeValue!;
//   //       // request.fields[DeliverableZipcodes] = deliverableZipcodes ??
//   //       //     "null"; // logic clear ////painding in implimentation
//   //       // request.fields[IsPricesInclusiveTax] = taxincludedinPrice!;
//   //       // request.fields[CodAllowed] = isCODAllow!;
//   //       // request.fields[IsReturnable] = isReturnable!;
//   //       // request.fields[IsCancelable] = isCancelable!;
//   //       // request.fields[ProInputImage] = productImage;
//   //       if (tillwhichstatus != null)
//   //         request.fields[CancelableTill] = tillwhichstatus!;
//   //       // for product Image ADD
//   //       if (selectedimage != null) {
//   //         request.files.add(await http.MultipartFile.fromPath(ProInputImage, selectedimage.path));
//   //       }
//   //       if (selectedimage2 != null) {
//   //         request.files.add(await http.MultipartFile.fromPath(OtherImages, selectedimage2.path));
//   //       }
//   //       print('edit prod request${request.fields} ${request.files} $selectedimage $selectedimage2');
//   //
//   //       /*var pic = await http.MultipartFile.fromPath(
//   //           ProInputImage, mainProductImage!.path);
//   //       request.files.add(pic);*/
//   //       // for Other Photos Add
//   //       // if (otherPhotos.isNotEmpty) {
//   //       //   request.fields[OtherImages] = otherPhotos.join(",");
//   //       //   /*  for (var i = 0; i < otherPhotos.length; i++) {
//   //       //     var pics = await http.MultipartFile.fromPath(
//   //       //         OtherImages, otherPhotos[i].path);
//   //       //     request.files.add(pics);
//   //       //   }*/
//   //       // }
//   //       // if (selectedTypeOfVideo != null)
//   //       //   request.fields[VideoType] = selectedTypeOfVideo!;
//   //       // if (vidioTypeController.text != "") request.fields[Video] = vidioTypeController.text;
//   //       // // for product video Add
//   //       // if (uploadedVideoName != '') {
//   //       //   request.fields[ProInputVideo] = uploadedVideoName;
//   //       // }
//   //       request.fields[ProInputDescription] = description!;
//   //       request.fields[CategoryId] = selectedCatID!;
//   //       //attribute_values
//   //       // this is complecated
//   //       request.fields[ProductType] = productType!;
//   //       request.fields[VariantStockLevelType] = variantStockLevelType!;
//   //       request.fields[AttributeValues] = attributesValuesIds.join(",");
//   //       // if(product_type == variable_product)
//   //       //simple product
//   //       if (productType == 'simple_product') {
//   //         String? status;
//   //         if (_isStockSelected == null)
//   //           status = null;
//   //         else
//   //           status = simpleproductStockStatus;
//   //         request.fields[SimpleProductStockStatus] = status ?? 'null';
//   //         request.fields[SimplePrice] = simpleProductPriceController.text;
//   //         request.fields[SimpleSpecialPrice] =
//   //             simpleProductSpecialPriceController.text;
//   //         if (_isStockSelected != null &&
//   //             _isStockSelected == true &&
//   //             simpleproductSKU != null) {
//   //           request.fields[ProductSku] = simpleProductSKUController.text;
//   //           request.fields[ProductTotalStock] = simpleProductTotalStock.text;
//   //           request.fields[VariantStockStatus] = "0";
//   //         }
//   //       }
//   //       // else if (productType == 'variable_product') {
//   //       //   String val = '', price = '', sprice = '', images = '';
//   //       //   for (int i = 0; i < variationList.length; i++) {
//   //       //     if (val == '') {
//   //       //       val = variationList[i].id!.replaceAll(',', ' ');
//   //       //       price = variationList[i].price!;
//   //       //       sprice = variationList[i].disPrice ?? ' ';
//   //       //       // images = variationList[i].images.join(",");
//   //       //     } else {
//   //       //       val = val + "," + variationList[i].id!.replaceAll(',', ' ');
//   //       //       price = price + "," + variationList[i].price!;
//   //       //       sprice = sprice + "," + (variationList[i].disPrice ?? ' ');
//   //       //       //images = images + ',' + variationList[i].images.join(",");
//   //       //     }
//   //       //     if (variationList[i].images != null) {
//   //       //       if (variationList[i].images!.isNotEmpty && images != '')
//   //       //         images = images + ',' + variationList[i].images!.join(",");
//   //       //       else if (variationList[i].images!.isNotEmpty && images == '')
//   //       //         images = variationList[i].images!.join(",");
//   //       //     }
//   //       //   }
//   //       //
//   //       //   request.fields[VariantsIds] = val;
//   //       //   request.fields[VariantPrice] = price;
//   //       //   request.fields[VariantSpecialPrice] = sprice;
//   //       //   request.fields[variant_images] = images;
//   //       //
//   //       //   if (variantStockLevelType == 'product_level') {
//   //       //     request.fields[SkuVariantType] = variountProductSKUController.text;
//   //       //     request.fields[TotalStockVariantType] =
//   //       //         variountProductTotalStock.text;
//   //       //     request.fields[VariantStatus] = stockStatus;
//   //       //   } else if (variantStockLevelType == 'variable_level') {
//   //       //     String sku = '', totalStock = '', stkStatus = '';
//   //       //     for (int i = 0; i < variationList.length; i++) {
//   //       //       if (sku == '') {
//   //       //         sku = variationList[i].sku!;
//   //       //         totalStock = variationList[i].stock!;
//   //       //         stkStatus = variationList[i].stockStatus!;
//   //       //       } else {
//   //       //         sku = sku + "," + variationList[i].sku!;
//   //       //         totalStock = totalStock + "," + variationList[i].stock!;
//   //       //         stkStatus = stkStatus + "," + (variationList[i].stockStatus!);
//   //       //       }
//   //       //     }
//   //       //
//   //       //     request.fields[VariantSku] = sku;
//   //       //     request.fields[VariantTotalStock] = totalStock;
//   //       //     request.fields[VariantLevelStockStatus] = stkStatus;
//   //       //   }
//   //       // }
//   //
//   //       print("reuest fieldssssss : ${request.fields}");
//   //       var response = await request.send();
//   //       var responseData = await response.stream.toBytes();
//   //       var responseString = String.fromCharCodes(responseData);
//   //       var getdata = json.decode(responseString);
//   //
//   //       bool error = getdata["error"];
//   //       String msg = getdata['message'];
//   //       print("msg here  ${msg} and ${error}");
//   //       if (!error) {
//   //         await buttonController!.reverse();
//   //         Navigator.pop(context);
//   //         // Navigator.pop(context);
//   //         // setSnackbar(msg);
//   //       } else {
//   //         await buttonController!.reverse();
//   //         // setSnackbar(msg);
//   //       }
//   //     } on TimeoutException catch (_) {
//   //       setSnackbar(
//   //         getTranslated(context, 'somethingMSg')!,
//   //       );
//   //     }
//   //   } else if (mounted) {
//   //     Future.delayed(Duration(seconds: 2)).then(
//   //           (_) async {
//   //         await buttonController!.reverse();
//   //         setState(
//   //               () {
//   //             _isNetworkAvail =
//   //             false; // impliment simmer for network availability
//   //           },
//   //         );
//   //       },
//   //     );
//   //   }
//   // }
//   Future<Null> _playAnimation() async {
//     try {
//       await buttonController!.forward();
//     } on TickerCanceled {}
//   }
//   getCategorys(int index) {
//     CategoryModel model = catagorylist[index];
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InkWell(
//           onTap: () {
//             selectedCatName = model.name;
//             selectedCatID = model.id;
//             setState(() {});
//           },
//           child: Container(
//
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.fiber_manual_record_rounded,
//                   size: 20,
//                   color: primary,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width/1.3,
//                   child: Text(
//                     model.name!,
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                     maxLines: 2,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           child: ListView.builder(
//             shrinkWrap: true,
//             padding: EdgeInsetsDirectional.only(bottom: 5, start: 15, end: 15),
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: model.children!.length,
//             itemBuilder: (context, index) {
//               CategoryModel? item1;
//               item1 = model.children!.isEmpty ? null : model.children![index];
//               return item1 == null
//                   ? Container(
//                 child: Text(
//                   getTranslated(context, "no sub cat")!,
//                 ),
//               )
//                   : Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       setState(() {});
//                       selectedCatName = item1!.name;
//                       selectedCatID = item1.id;
//                     },
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Icon(
//                           Icons.subdirectory_arrow_right_outlined,
//                           color: secondary,
//                           size: 20,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           item1.name!,
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       padding: EdgeInsetsDirectional.only(
//                           bottom: 5, start: 10, end: 10),
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: item1.children!.length,
//                       itemBuilder: (context, index) {
//                         CategoryModel? item2;
//                         item2 = item1!.children!.isEmpty
//                             ? null
//                             : item1.children![index];
//                         return item2 == null
//                             ? Container()
//                             : Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 setState(() {});
//                                 selectedCatName = item2!.name;
//                                 selectedCatID = item2.id;
//                               },
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Icon(
//                                     Icons
//                                         .subdirectory_arrow_right_outlined,
//                                     color: primary,
//                                     size: 20,
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     item2.name!,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsetsDirectional.only(
//                                     bottom: 5, start: 10, end: 10),
//                                 physics:
//                                 NeverScrollableScrollPhysics(),
//                                 itemCount: item2.children!.length,
//                                 itemBuilder: (context, index) {
//                                   CategoryModel? item3;
//                                   item3 = item2!.children!.isEmpty
//                                       ? null
//                                       : item2.children![index];
//                                   return item3 == null
//                                       ? Container()
//                                       : Column(
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {});
//                                           selectedCatName =
//                                               item3!.name;
//                                           selectedCatID =
//                                               item3.id;
//                                         },
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             Icon(
//                                               Icons
//                                                   .subdirectory_arrow_right_outlined,
//                                               color:
//                                               secondary,
//                                               size: 20,
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(item3.name!),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         child:
//                                         ListView.builder(
//                                           shrinkWrap: true,
//                                           padding:
//                                           EdgeInsetsDirectional
//                                               .only(
//                                               bottom:
//                                               5,
//                                               start:
//                                               10,
//                                               end:
//                                               10),
//                                           physics:
//                                           NeverScrollableScrollPhysics(),
//                                           itemCount: item3
//                                               .children!
//                                               .length,
//                                           itemBuilder:
//                                               (context,
//                                               index) {
//                                             CategoryModel?
//                                             item4;
//                                             item4 = item3!
//                                                 .children!
//                                                 .isEmpty
//                                                 ? null
//                                                 : item3.children![
//                                             index];
//                                             return item4 ==
//                                                 null
//                                                 ? Container()
//                                                 : Column(
//                                               children: [
//                                                 InkWell(
//                                                   onTap:
//                                                       () {
//                                                     setState(() {});
//                                                     selectedCatName =
//                                                         item4!.name;
//                                                     selectedCatID =
//                                                         item4.id;
//                                                   },
//                                                   child:
//                                                   Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: 10,
//                                                       ),
//                                                       Icon(
//                                                         Icons.subdirectory_arrow_right_outlined,
//                                                         color: primary,
//                                                         size: 20,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text(item4.name!),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   child:
//                                                   ListView.builder(
//                                                     shrinkWrap:
//                                                     true,
//                                                     padding: EdgeInsetsDirectional.only(
//                                                         bottom: 5,
//                                                         start: 10,
//                                                         end: 10),
//                                                     physics:
//                                                     NeverScrollableScrollPhysics(),
//                                                     itemCount:
//                                                     item4.children!.length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       CategoryModel? item5;
//                                                       item5 = item4!.children!.isEmpty ? null : item4.children![index];
//                                                       return item5 == null
//                                                           ? Container()
//                                                           : Column(
//                                                         children: [
//                                                           InkWell(
//                                                             onTap: () {
//                                                               setState(() {});
//                                                               selectedCatName = item5!.name;
//                                                               selectedCatID = item5.id;
//                                                             },
//                                                             child: Row(
//                                                               children: [
//                                                                 SizedBox(
//                                                                   width: 10,
//                                                                 ),
//                                                                 Icon(
//                                                                   Icons.subdirectory_arrow_right_outlined,
//                                                                   color: secondary,
//                                                                   size: 20,
//                                                                 ),
//                                                                 SizedBox(
//                                                                   width: 5,
//                                                                 ),
//                                                                 Text(item5.name!),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       );
//                                                     },
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//   mainImage() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             getTranslated(context, "Main Image * ")!,
//           ),
//           InkWell(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: primary,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               width: 90,
//               height: 40,
//               child: Center(
//                 child: Text(
//                   getTranslated(context, "Upload")!,
//                   style: TextStyle(
//                     color: white,
//                   ),
//                 ),
//               ),
//             ),
//             onTap: ()async {
//               _image_camera_dialog(context);
//               // var result = await  Navigator.push(context, MaterialPageRoute(builder: (context) => Media(from: "main"),),);
//               // if(result!=null){
//               //   setState((){
//               //     productImage =
//               //     result[0];
//               //     productImageUrl = result[1];
//               //   });
//               // }
//             },
//           ),
//         ],
//       ),
//     );
//   }
//   selectedMainImageShow() {
//     return selectedimage == null || selectedimage == ""
//         ? Container()
//         :Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: ClipRRect(
//         borderRadius:
//         BorderRadius.circular(10),
//         child: Image.file(
//           File(selectedimage?.path ?? ""),
//           fit: BoxFit.fill,
//           height: 200,
//         ),
//       ),
//     );
//     // return productImage == ''
//     //     ? Container()
//     //     : Image.network(
//     //   productImageUrl,
//     //   width: 100,
//     //   height: 100,
//     // );
//   }
//   otherImages(String from, int pos) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             getTranslated(context, "Other Images")!,
//           ),
//           InkWell(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: primary,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               width: 90,
//               height: 40,
//               child: Center(
//                 child: Text(
//                   getTranslated(context, "Upload")!,
//                   style: TextStyle(
//                     color: white,
//                   ),
//                 ),
//               ),
//             ),
//             onTap: () async{
//               _image_camera_dialog2(context);
//               // var result = await  Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => Media( from: from,
//               //       pos: pos,),
//               //   ),
//               // );
//               // if(result!=null){
//               //   setState((){
//               //     otherPhotos =
//               //     result[0];
//               //     otherImageUrl = result[1];
//               //   });
//               // }
//               //otherImagesFromGallery();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//   uploadedOtherImageShow() {
//     return selectedimage2 == null || selectedimage2 == ""
//         ? Container()
//         :Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: ClipRRect(
//         borderRadius:
//         BorderRadius.circular(10),
//         child: Image.file(
//           File(selectedimage2?.path ?? ""),
//           fit: BoxFit.fill,
//           height: 200,
//         ),
//       ),
//     );
//     // return otherImageUrl.isEmpty
//     //     ? Container()
//     //     : Container(
//     //   width: double.infinity,
//     //   height: 105,
//     //   child: ListView.builder(
//     //     shrinkWrap: true,
//     //     itemCount: otherPhotos.length,
//     //     scrollDirection: Axis.horizontal,
//     //     itemBuilder: (context, i) {
//     //       return InkWell(
//     //         child: Stack(
//     //           alignment: AlignmentDirectional.topEnd,
//     //           children: [
//     //
//     //             Image.network(
//     //               otherImageUrl[i],
//     //               width: 100,
//     //               height: 100,
//     //             ),
//     //             Container(
//     //               color: Colors.black26,
//     //               child: const Icon(
//     //                 Icons.clear,
//     //                 size: 15,
//     //               ),
//     //             )
//     //           ],
//     //         ),
//     //         onTap: () {
//     //           if (mounted) {
//     //             setState(
//     //                   () {
//     //                 otherPhotos.removeAt(i);
//     //               },
//     //             );
//     //           }
//     //         },
//     //       );
//     //     },
//     //   ),
//     // );
//   }
//   longDescription() {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 8.0,
//         left: 8.0,
//         right: 8.0,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             getTranslated(context, "Description")! + " :",
//             style: TextStyle(fontSize: 16),
//           ),
//           SizedBox(
//             height: 05,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: lightWhite,
//               border: Border.all(
//                 color: primary,
//               ),
//             ),
//             width: width,
//             height: height * 0.2,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 left: 8,
//                 right: 8,
//               ),
//               child: TextFormField(
//                 initialValue: description,
//                 textInputAction: TextInputAction.newline,
//                 keyboardType: TextInputType.multiline,
//                 minLines: null,
//                 validator: (val) => validateThisFieldRequered(val, context),
//
//                 onChanged: (String? value) {
//                   description = value;
//                 },
//                 maxLines: null,
//                 // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
//                 expands: true, // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   typeSelectionField() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: InkWell(
//         child: Container(
//           padding: EdgeInsets.only(
//             top: 5,
//             bottom: 5,
//             left: 5,
//             right: 5,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: lightBlack,
//               width: 1,
//             ),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     productType != null
//                         ? Text(
//                       productType == 'simple_product'
//                           ? getTranslated(context, "Simple Product")!
//                           : getTranslated(context, "Variable Product")!,
//                     )
//                         : Text(
//                       getTranslated(context, "Select Type")!,
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_drop_down,
//                 color: primary,
//               )
//             ],
//           ),
//         ),
//         onTap: () {
//           FocusScope.of(context).requestFocus(new FocusNode());
//           productTypeDialog();
//         },
//       ),
//     );
//   }
//   productTypeDialog() async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setStater) {
//             taxesState = setStater;
//             return AlertDialog(
//               contentPadding: const EdgeInsets.all(0.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(5.0),
//                 ),
//               ),
//               content: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           getTranslated(context, "Select Type")!,
//                           style: Theme.of(this.context)
//                               .textTheme
//                               .subtitle1!
//                               .copyWith(color: fontColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(color: lightBlack),
//                   Flexible(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(
//                                     () {
//                                   variantProductVariableLevelSaveSettings =
//                                   false;
//                                   variantProductProductLevelSaveSettings =
//                                   false;
//                                   simpleProductSaveSettings = false;
//                                   productType = 'simple_product';
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                             child: Container(
//                               width: double.maxFinite,
//                               child: Padding(
//                                 padding:
//                                 EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       getTranslated(context, "Simple Product")!,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // InkWell(
//                           //   onTap: () {
//                           //     setState(
//                           //       () {
//                           //         //----reset----
//                           //         simpleProductPriceController.text = '';
//                           //         simpleProductSpecialPriceController.text = '';
//                           //         _isStockSelected = false;
//                           //
//                           //         //--------------set
//                           //         variantProductVariableLevelSaveSettings =
//                           //             false;
//                           //         variantProductProductLevelSaveSettings =
//                           //             false;
//                           //         simpleProductSaveSettings = false;
//                           //         productType = 'variable_product';
//                           //         Navigator.of(context).pop();
//                           //       },
//                           //     );
//                           //   },
//                           //   child: Container(
//                           //     width: double.maxFinite,
//                           //     child: Padding(
//                           //       padding:
//                           //           EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
//                           //       child: Row(
//                           //         mainAxisAlignment:
//                           //             MainAxisAlignment.spaceBetween,
//                           //         children: [
//                           //           Text(
//                           //             getTranslated(
//                           //                 context, "Variable Product")!,
//                           //           ),
//                           //         ],
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//   additionalInfo() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         padding: EdgeInsets.all(5.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(
//             color: primary,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.end,
//             //   children: [
//             //     TextButton(
//             //       style: curSelPos == 0
//             //           ? TextButton.styleFrom(
//             //         primary: Colors.white,
//             //         backgroundColor: primary,
//             //         onSurface: Colors.grey,
//             //       )
//             //           : null,
//             //       onPressed: () {
//             //         setState(
//             //               () {
//             //             curSelPos = 0;
//             //           },
//             //         );
//             //       },
//             //       child: Text(
//             //         getTranslated(context, "General Information")!,
//             //       ),
//             //     ),
//             //     TextButton(
//             //       style: curSelPos == 1
//             //           ? TextButton.styleFrom(
//             //         primary: Colors.white,
//             //         backgroundColor: primary,
//             //         onSurface: Colors.grey,
//             //       )
//             //           : null,
//             //       onPressed: () {
//             //         setState(
//             //               () {
//             //             curSelPos = 1;
//             //           },
//             //         );
//             //       },
//             //       child: Text(
//             //         getTranslated(context, "Attributes")!,
//             //       ),
//             //     ),
//             //     productType == 'variable_product'
//             //         ? TextButton(
//             //       style: curSelPos == 2
//             //           ? TextButton.styleFrom(
//             //         primary: Colors.white,
//             //         backgroundColor: primary,
//             //         onSurface: Colors.grey,
//             //       )
//             //           : null,
//             //       onPressed: () {
//             //         setState(
//             //               () {
//             //             curSelPos = 2;
//             //           },
//             //         );
//             //       },
//             //       child: Text(
//             //         getTranslated(context, "Variations")!,
//             //       ),
//             //     )
//             //         : Container(),
//             //   ],
//             // ),
//             TextButton(
//               style: curSelPos == 0
//                   ? TextButton.styleFrom(
//                 primary: Colors.white,
//                 backgroundColor: primary,
//                 onSurface: Colors.grey,
//               )
//                   : null,
//               onPressed: () {
//                 setState(
//                       () {
//                     curSelPos = 0;
//                   },
//                 );
//               },
//               child: Text(
//                 getTranslated(context, "General Information")!,
//               ),
//             ),
//
//             //general section
//             curSelPos == 0
//                 ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                       getTranslated(context, "Type Of Product")! + " :"),
//                 ),
//                 typeSelectionField(),
//
//                 // For Simple Product
//
//                 productType == 'simple_product'
//                     ? simpleProductPrice()
//                     : Container(),
//                 productType == 'simple_product'
//                     ? simpleProductSpecialPrice()
//                     : Container(),
//
//                 CheckboxListTile(
//                   title: Text(
//                     getTranslated(context, "Enable Stock Management")!,
//                   ),
//                   value: _isStockSelected ?? false,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       _isStockSelected = value!;
//                     });
//                   },
//                 ),
//                 _isStockSelected != null &&
//                     _isStockSelected == true &&
//                     productType == 'simple_product'
//                     ? simpleProductSKU()
//                     : Container(),
//
//                 productType == 'simple_product'
//                     ? /*InkWell(
//                     onTap: () {
//                       setState(
//                         () {
//                           simpleProductSaveSettings = true;
//                         },
//                       );
//                     },
//                     child: FlatButton(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: secondary,
//                       ),
//                       width: 150,
//                       height: 50,
//                       child: Center(
//                         child: Text(
//                           getTranslated(context, "Save Settings")!,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )*/
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: SimBtn(
//                     title: getTranslated(context, "Save Settings")!,
//                     size: MediaQuery.of(context).size.width * 0.5,
//                     onBtnSelected: () {
//                       if (simpleProductPriceController
//                           .text.isEmpty) {
//                         setSnackbar(
//                           getTranslated(context,
//                               "Please enter product price")!,
//                         );
//                       } else if (simpleProductSpecialPriceController
//                           .text.isEmpty) {
//                         setState(
//                               () {
//                             simpleProductSaveSettings = true;
//                             setSnackbar(
//                               getTranslated(context,
//                                   "Setting saved successfully")!,
//                             );
//                           },
//                         );
//                       } else if (int.parse(simpleProductPriceController.text) <
//                           int.parse(simpleProductSpecialPriceController.text)) {
//                         setSnackbar(
//                           getTranslated(context,
//                               "Special price must be less than original price")!,
//                         );
//                       } else {
//                         setState(
//                               () {
//                             simpleProductSaveSettings = true;
//                             setSnackbar(
//                               getTranslated(context,
//                                   "Setting saved successfully")!,
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//                 )
//                     : Container(),
//
//                 // For Variant Product
//
//                 _isStockSelected != null &&
//                     _isStockSelected == true &&
//                     productType == 'variable_product'
//                     ? variableProductStockManagementType()
//                     : Container(),
//
//                 productType == 'variable_product' &&
//                     variantStockLevelType == "product_level" &&
//                     _isStockSelected != null &&
//                     _isStockSelected == true
//                     ? Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     variableProductSKU(),
//                     variantProductTotalstock(),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         getTranslated(context, "Stock Status :")!,
//                       ),
//                     ),
//                     productStockStatusSelect()
//                   ],
//                 )
//                     : Container(),
//
//                 productType == 'variable_product' &&
//                     variantStockLevelType == "product_level"
//                     ? SimBtn(
//                   title: getTranslated(context, "Save Settings")!,
//                   size: MediaQuery.of(context).size.width * 0.5,
//                   onBtnSelected: () {
//                     if (_isStockSelected != null &&
//                         _isStockSelected == true &&
//                         (variountProductTotalStock.text.isEmpty ||
//                             stockStatus.isEmpty))
//                       setSnackbar(
//                         getTranslated(
//                             context, "Please enter all details")!,
//                       );
//                     else
//                       setState(
//                             () {
//                           variantProductProductLevelSaveSettings =
//                           true;
//                           setSnackbar(
//                             getTranslated(context,
//                                 "Setting saved successfully")!,
//                           );
//                         },
//                       );
//                   },
//                 )
//                     : Container(),
//
// //setting button
//                 productType == 'variable_product' &&
//                     variantStockLevelType == "variable_level"
//                     ? SimBtn(
//                   title: getTranslated(context, "Save Settings")!,
//                   size: MediaQuery.of(context).size.width * 0.5,
//                   onBtnSelected: () {
//                     setState(
//                           () {
//                         variantProductVariableLevelSaveSettings =
//                         true;
//                         setSnackbar(
//                           getTranslated(context,
//                               "Setting saved successfully")!,
//                         );
//                       },
//                     );
//                   },
//                 )
//                     : Container(),
//               ],
//             )
//                 : Container(),
//             //attribute section
//             curSelPos == 1 &&
//                 (simpleProductSaveSettings ||
//                     variantProductVariableLevelSaveSettings ||
//                     variantProductProductLevelSaveSettings)
//                 ? Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           child: Text(
//                             getTranslated(context, "Attributes")!,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         OutlinedButton(
//                           onPressed: () {
//                             if (attributeIndiacator ==
//                                 _attrController.length) {
//                               setState(() {
//                                 _attrController
//                                     .add(new TextEditingController());
//                                 _attrValController
//                                     .add(new TextEditingController());
//                                 variationBoolList.add(false);
//                               });
//                             } else {
//                               setSnackbar(getTranslated(context,
//                                   "fill the box then add another")!);
//                             }
//                           },
//                           child: Text(
//                             getTranslated(context, "Add Attribute")!,
//                           ),
//                         ),
//                         OutlinedButton(
//                           onPressed: () {
//                             tempAttList.clear();
//                             List<String> attributeIds = [];
//                             for (var i = 0;
//                             i < variationBoolList.length;
//                             i++) {
//                               if (variationBoolList[i]) {
//                                 final attributes = attributesList
//                                     .where((element) =>
//                                 element.name ==
//                                     _attrController[i].text)
//                                     .toList();
//                                 if (attributes.isNotEmpty) {
//                                   attributeIds.add(attributes.first.id!);
//                                 }
//                               }
//                             }
//                             setState(() {
//                               resultAttr = [];
//                               resultID = [];
//                               variationList = [];
//                               finalAttList = [];
//                               attributeIds.forEach((key) {
//                                 tempAttList
//                                     .add(selectedAttributeValues[key]!);
//                               });
//                               for (int i = 0;
//                               i < tempAttList.length;
//                               i++) {
//                                 finalAttList.add(tempAttList[i]);
//                               }
//                               if (finalAttList.length > 0) {
//                                 max = finalAttList.length - 1;
//
//                                 getCombination([], [], 0);
//                                 row = 1;
//                                 col = max + 1;
//                                 for (int i = 0; i < col; i++) {
//                                   int singleRow = finalAttList[i].length;
//                                   row = row * singleRow;
//                                 }
//                               }
//                               setSnackbar(
//                                 getTranslated(context,
//                                     "Attributes saved successfully")!,
//                               );
//                             });
//                           },
//                           child: Text(
//                               getTranslated(context, "Save Attribute")!),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 productType == 'variable_product'
//                     ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     getTranslated(
//                       context,
//                       "Note : select checkbox if the attribute is to be used for variation",
//                     )!,
//                   ),
//                 )
//                     : Container(),
//                 for (int i = 0; i < _attrController.length; i++)
//                   addAttribute(i)
//               ],
//             )
//                 : Container(),
//
// //variation section
//
//             curSelPos == 2 && variationList.length > 0
//                 ? ListView.builder(
//               itemCount: row,
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, i) {
//                 return new ExpansionTile(
//                   title: Row(
//                     children: [
//                       for (int j = 0; j < col; j++)
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0),
//                             child: Text(variationList[i]
//                                 .attr_name!
//                                 .split(',')[j]),
//                           ),
//                         ),
//                       InkWell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Icon(
//                             Icons.close,
//                           ),
//                         ),
//                         onTap: () {
//                           setState(() {
//                             variationList.removeAt(i);
//
//                             for (int i = 0; i < variationList.length; i++)
//                               row = row - 1;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   children: <Widget>[
//                     new Column(
//                       children: _buildExpandableContent(i),
//                     ),
//                   ],
//                 );
//               },
//             )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
//
// }
