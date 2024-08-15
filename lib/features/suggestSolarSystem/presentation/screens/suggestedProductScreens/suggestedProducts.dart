// import 'package:alternative_energy_user_app/core/constants.dart';
// import 'package:alternative_energy_user_app/core/utils/size_config.dart';
// import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/suggestedProducts.dart';
// import 'package:flutter/material.dart';
// class SuggestedproductsScreen extends StatelessWidget {
//   final Suggestedproducts product;

//   const SuggestedproductsScreen({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'المنظومة المقترحة ',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.75,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//             ),
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               String imageUrl = '';
//               String productName = '';
//               String priceText = ''; // تغيير إلى String

//               if (index == 0) {
//                 imageUrl = product.panels.details.image;
//                 productName = product.panels.details.name;
//                 priceText = '${product.panels.details.price} جنيه'; // تحويل int إلى String
//               } else if (index == 1) {
//                 imageUrl = product.batteries.lithium.image;
//                 productName = 'بطارية ليثيوم';
//                 priceText = '${product.batteries.lithium.price} جنيه'; // تحويل int إلى String
//               } else if (index == 2) {
//                 imageUrl = product.inverter.details.image;
//                 productName = product.inverter.details.name;
//                 priceText = '${product.inverter.details.price} جنيه'; // تحويل int إلى String
//               }

//               return Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 width: 200,
//                 height: 200,
//                 margin: EdgeInsets.all(8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//                         child: Image.network(
//                           "http://${AppConstants.ip}:8000/$imageUrl",
//                           height: SizeConfig.defaultSize * 12,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             productName,
//                             style: TextStyle(
//                               color: AppConstants.orangeColor,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             priceText,
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
