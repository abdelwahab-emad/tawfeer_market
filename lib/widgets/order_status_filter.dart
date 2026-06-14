// import 'package:flutter/material.dart';
// import 'package:tawfeer_market/constants.dart';

// class OrderStatusFilter extends StatefulWidget {
//   @override
//   State<OrderStatusFilter> createState() => _OrderStatusFilterState();
// }

// class _OrderStatusFilterState extends State<OrderStatusFilter> {
//   String selectedStatus = 'All';

//   final List<String> statuses = [
//     'All',
//     'Pending',
//     'Confirmed',
//     'Delivered',
//     'Cancelled',
//   ];

//   final List<Map<String, dynamic>> allOrders = [
//     {
//       'id': '#TF9EkIVr',
//       'date': '2026-06-14 - 09:46',
//       'status': 'Pending',
//       'items': '1 Item · Almarai Skinned Milk',
//       'price': '46.5 EGP',
//     },
//     {
//       'id': '#TF7MnXpQ',
//       'date': '2026-06-14 - 08:30',
//       'status': 'Confirmed',
//       'items': '3 Items · Nutella, Coffee...',
//       'price': '312 EGP',
//     },
//     {
//       'id': '#TF5XyZ21',
//       'date': '2026-06-14 - 07:15',
//       'status': 'Delivered',
//       'items': '2 Items · Potato Chips, Cola',
//       'price': '85 EGP',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final filterdOrders = selectedStatus == 'All'
//         ? allOrders
//         : allOrders
//               .where((order) => order['status'] == selectedStatus)
//               .toList();
//     return SizedBox(
//       height: 38,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: statuses.length,
//         itemBuilder: (context, index) {
//           final status = statuses[index];
//           final isSelected = status == selectedStatus;
//           return Padding(
//             padding: const EdgeInsets.only(right: 12.0),
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedStatus = status;
//                 });
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? Color(kprimarycolor)
//                       : const Color(0xFFE0E0E0),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Center(
//                   child: Text(
//                     status,
//                     style: TextStyle(
//                       color: isSelected
//                           ? Colors.white
//                           : const Color(0xFF616161),
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
