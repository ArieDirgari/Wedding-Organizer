// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/material.dart';
// import 'package:teori/M06/page2.dart';
// import 'package:teori/M06/page3.dart';

// class Minggu06 extends StatefulWidget {
//   const Minggu06({super.key});

//   @override
//   State<Minggu06> createState() => _Minggu06State();
// }

// class _Minggu06State extends State<Minggu06> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Minggu 06"),
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: (){
//                 FirebaseAnalytics.instance.logEvent(name: "Ke_Halaman_2");
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => Page2())
//                 );
//               },
//               child: Text("Page 2"),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.redAccent
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: (){
//                 FirebaseAnalytics.instance.logEvent(name: "reserved");
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => Page3())
//                 );
//               },
//               child: Text("Page 3"),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.redAccent
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
