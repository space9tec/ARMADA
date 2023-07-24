// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../provider/drop_down_provider.dart';
// import '../screens.dart';

// class VerifyFarm extends StatefulWidget {
//   static const String routeName = '/VerifyFarm';

//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (context) {
//         return const VerifyFarm();
//       },
//     );
//   }

//   const VerifyFarm({super.key});

//   @override
//   State<VerifyFarm> createState() => _VerifyFarmState();
// }

// class _VerifyFarmState extends State<VerifyFarm> {
//   // final TextEditingController _farmNamecontroller = TextEditingController();
//   // final TextEditingController _farmSizecontroller = TextEditingController();
//   // final TextEditingController _farmLocationcontroller = TextEditingController();
//   // final TextEditingController _cropTypecontroller = TextEditingController();
//   // final TextEditingController _soilTypecontroller = TextEditingController();
//   // final TextEditingController _passwordcontroller = TextEditingController();

//   bool value = false;

//   @override
//   Widget build(BuildContext context) {
//     switch (
//         Provider.of<DropDownProvider>(context, listen: false).selectedAccount) {
//       case 'Service Provider':
//         return VerifyServiceProvider();
//       case 'Farmer':
//         return VerifyFarms();
//       default:
//         return const Verify();
//     }
//   }
// }
