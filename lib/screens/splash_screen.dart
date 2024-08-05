// import 'package:flutter/material.dart';

// class SplashHandler extends StatefulWidget {
//   @override
//   _SplashHandlerState createState() => _SplashHandlerState();
// }

// class _SplashHandlerState extends State<SplashHandler> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToHome();
//   }

//   _navigateToHome() async {
//     await Future.delayed(Duration(seconds: 3), () {});
//     Navigator.pushReplacementNamed(context, '/home');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFD3E004),
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 15,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 75,
//                 child: Image.asset('assets/logo1.png', width: 100),
//               ),
//             ),
//             Positioned(
//               bottom: 30,
//               child: Text(
//                 'PetCare',
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue.shade700,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
