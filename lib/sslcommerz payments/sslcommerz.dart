// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_sslcommerze/model/SSLCAdditionalInitializer.dart';
// import 'package:flutter_sslcommerze/model/SSLCCustomerInfoInitializer.dart';
// import 'package:flutter_sslcommerze/model/SSLCEMITransactionInitializer.dart';
// import 'package:flutter_sslcommerze/model/SSLCSdkType.dart';
// import 'package:flutter_sslcommerze/model/SSLCShipmentInfoInitializer.dart';
// import 'package:flutter_sslcommerze/model/SSLCTransactionInfoModel.dart';
// import 'package:flutter_sslcommerze/model/SSLCommerzInitialization.dart';
// import 'package:flutter_sslcommerze/model/SSLCurrencyType.dart';
// import 'package:flutter_sslcommerze/model/sslproductinitilizer/General.dart';
// import 'package:flutter_sslcommerze/model/sslproductinitilizer/SSLCProductInitializer.dart';
// import 'package:flutter_sslcommerze/sslcommerz.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class Sslcommerz1 {
//   String multicardname;
//   String storeid;
//   String storepassword;
//   double ammount;
//   String phonenumber;
//   Sslcommerz1(
//       {required this.ammount,
//       required this.multicardname,
//       required this.phonenumber,
//       required this.storeid,
//       required this.storepassword});
//    Future<void> sslCommerzGeneralCall() async {
//     Sslcommerz sslcommerz = Sslcommerz(
//         initializer: SSLCommerzInitialization(
//             //Use the ipn if you have valid one, or it will fail the transaction.
//             ipn_url: "www.ipnurl.com",
//             multi_card_name: multicardname,
//             currency: SSLCurrencyType.BDT,
//             product_category: "Food",
//             sdkType: SSLCSdkType.TESTBOX,
//             store_id: storeid,
//             store_passwd: storepassword,
//             total_amount: ammount,
//             tran_id: "1231321321321312"));
//     sslcommerz.payNow();
//   }

//   Future<void> sslCommerzCustomizedCall() async {
//     Sslcommerz sslcommerz = Sslcommerz(
//         initializer: SSLCommerzInitialization(
//             //Use the ipn if you have valid one, or it will fail the transaction.
//             ipn_url: "www.ipnurl.com",
//             multi_card_name: multicardname,
//             currency: SSLCurrencyType.BDT,
//             product_category: "Food",
//             sdkType: SSLCSdkType.LIVE,
//             store_id: storeid,
//             store_passwd: storepassword,
//             total_amount: ammount,
//             tran_id: "1231321321321312"));
//     sslcommerz
//         .addEMITransactionInitializer(
//             sslcemiTransactionInitializer: SSLCEMITransactionInitializer(
//                 emi_options: 1, emi_max_list_options: 3, emi_selected_inst: 2))
//         .addShipmentInfoInitializer(
//             sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
//                 shipmentMethod: "yes",
//                 numOfItems: 5,
//                 shipmentDetails: ShipmentDetails(
//                     shipAddress1: "Ship address 1",
//                     shipCity: "Faridpur",
//                     shipCountry: "Bangladesh",
//                     shipName: "Ship name 1",
//                     shipPostCode: "7860")))
//         .addCustomerInfoInitializer(
//             customerInfoInitializer: SSLCCustomerInfoInitializer(
//                 customerState: "Chattogram",
//                 customerName: "Abu Sayed Chowdhury",
//                 customerEmail: "sayem227@gmail.com",
//                 customerAddress1: "Anderkilla",
//                 customerCity: "Chattogram",
//                 customerPostCode: "200",
//                 customerCountry: "Bangladesh",
//                 customerPhone: phonenumber))
//         .addProductInitializer(
//             sslcProductInitializer:
//                 // ***** ssl product initializer for general product STARTS*****
//                 SSLCProductInitializer(
//                     productName: "Water Filter",
//                     productCategory: "Widgets",
//                     general: General(
//                         general: "General Purpose",
//                         productProfile: "Product Profile"))
//             // ***** ssl product initializer for general product ENDS*****

//             // ***** ssl product initializer for non physical goods STARTS *****
//             // SSLCProductInitializer.WithNonPhysicalGoodsProfile(
//             //     productName:
//             //   "productName",
//             //   productCategory:
//             //   "productCategory",
//             //   nonPhysicalGoods:
//             //   NonPhysicalGoods(
//             //      productProfile:
//             //       "Product profile",
//             //     nonPhysicalGoods:
//             //     "non physical good"
//             //       ))
//             // ***** ssl product initializer for non physical goods ENDS *****

//             // ***** ssl product initialization for travel vertices STARTS *****
//             //       SSLCProductInitializer.WithTravelVerticalProfile(
//             //          productName:
//             //         "productName",
//             //         productCategory:
//             //         "productCategory",
//             //         travelVertical:
//             //         TravelVertical(
//             //               productProfile: "productProfile",
//             //               hotelName: "hotelName",
//             //               lengthOfStay: "lengthOfStay",
//             //               checkInTime: "checkInTime",
//             //               hotelCity: "hotelCity"
//             //             )
//             //       )
//             // ***** ssl product initialization for travel vertices ENDS *****

//             // ***** ssl product initialization for physical goods STARTS *****

//             // SSLCProductInitializer.WithPhysicalGoodsProfile(
//             //     productName: "productName",
//             //     productCategory: "productCategory",
//             //     physicalGoods: PhysicalGoods(
//             //         productProfile: "Product profile",
//             //         physicalGoods: "non physical good"))

//             // ***** ssl product initialization for physical goods ENDS *****

//             // ***** ssl product initialization for telecom vertice STARTS *****
//             // SSLCProductInitializer.WithTelecomVerticalProfile(
//             //     productName: "productName",
//             //     productCategory: "productCategory",
//             //     telecomVertical: TelecomVertical(
//             //         productProfile: "productProfile",
//             //         productType: "productType",
//             //         topUpNumber: "topUpNumber",
//             //         countryTopUp: "countryTopUp"))
//             // ***** ssl product initialization for telecom vertice ENDS *****
//             )
//         .addAdditionalInitializer(
//             sslcAdditionalInitializer: SSLCAdditionalInitializer(
//                 valueA: "value a ",
//                 valueB: "value b",
//                 valueC: "value c",
//                 valueD: "value d"));
//     var result = await sslcommerz.payNow();
//     if (result is PlatformException) {
//       print("the response is: " +
//           result.message.toString() +
//           " code: " +
//           result.code);
//     } else {
//       SSLCTransactionInfoModel model = result;
//       Fluttertoast.showToast(
//           msg: "Transaction successful: Amount ${model.amount} TK",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.black,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//   }
// }
