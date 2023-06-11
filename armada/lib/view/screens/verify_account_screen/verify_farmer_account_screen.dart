import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../provider/drop_down_provider.dart';
import '../screens.dart';

class VerifyFarm extends StatefulWidget {
  static const String routeName = '/VerifyFarm';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const VerifyFarm();
      },
    );
  }

  const VerifyFarm({super.key});

  @override
  State<VerifyFarm> createState() => _VerifyFarmState();
}

class _VerifyFarmState extends State<VerifyFarm> {
  // String userRole = Provider.of<DropDownProvider>(listen: false)
  //     .selectedAccount;

  final TextEditingController _farmNamecontroller = TextEditingController();
  final TextEditingController _farmSizecontroller = TextEditingController();
  final TextEditingController _farmLocationcontroller = TextEditingController();
  final TextEditingController _cropTypecontroller = TextEditingController();
  final TextEditingController _soilTypecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool value = false;

  @override
  Widget build(BuildContext context) {
    switch (
        Provider.of<DropDownProvider>(context, listen: false).selectedAccount) {
      case 'Service Provider':
        return VerifyServiceProvider();
      case 'Farmer':
        return VerifyFarms();
      default:
        return const Verify();
    }
  }
}

// Scaffold(
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   addVerticalSpace(55.0),
//                   Center(
//                     child: Text("Account Info.",
//                         style: Theme.of(context).textTheme.displayLarge),
//                   ),
//                   addVerticalSpace(50.0),
//                   InputText(
//                       context,
//                       "Farm name",
//                       "gbre",
//                       false,
//                       Icons.phone_sharp,
//                       TextInputType.phone,
//                       _farmNamecontroller),
//                   addVerticalSpace(31.0),
//                   InputText(
//                       context,
//                       "Farm size",
//                       "214",
//                       false,
//                       Icons.lock_sharp,
//                       TextInputType.text,
//                       _farmSizecontroller),
//                   addVerticalSpace(31.0),
//                   InputText(
//                       context,
//                       "Farm Location",
//                       "awday",
//                       false,
//                       Icons.lock_sharp,
//                       TextInputType.text,
//                       _farmLocationcontroller),
//                   addVerticalSpace(31.0),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 28.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Optinal",
//                           textAlign: TextAlign.left,
//                           style: Theme.of(context).textTheme.displayMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                   addVerticalSpace(31.0),
//                   InputText(
//                       context,
//                       "Crop type",
//                       "teff",
//                       true,
//                       Icons.lock_sharp,
//                       TextInputType.text,
//                       _cropTypecontroller),
//                   addVerticalSpace(31.0),
//                   InputText(context, "Soil Type", "red", true, Icons.lock_sharp,
//                       TextInputType.text, _soilTypecontroller),
//                   addVerticalSpace(31.0),
//                   InputText(context, "hello", "owee", true, Icons.lock_sharp,
//                       TextInputType.text, _cropTypecontroller),
//                   addVerticalSpace(40.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Button(context, "Verify", '/',
//                           Theme.of(context).primaryColor, 200, 50),
//                       addHorizontalSpace(25),
//                       Button(context, "cancel", '/', Colors.grey, 325, 40),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );