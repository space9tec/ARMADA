// import 'package:flutter/material.dart';

// class Help extends StatefulWidget {
//   static const String routeName = '/help';

//   static Route route() {
//     return MaterialPageRoute(
//       settings: RouteSettings(name: routeName),
//       builder: (context) => Help(),
//     );
//   }

//   const Help({super.key});

//   @override
//   State<Help> createState() => _HelpState();
// }

// class _HelpState extends State<Help> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Help"),
//         elevation: 0,
//         backgroundColor: Theme.of(context).primaryColor,
//         actions: [],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'ARMADA AgriTech',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Version 1.0.0',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'This application allows users to book Farm machinerys. It provides a wide range of machinery options. If you have any questions or feedback, please contact us at support@armada.com.',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  static const String routeName = '/help';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => HelpPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Welcome to the Agricultural Machinery Booking App Help Page!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'If you need assistance with any aspect of the app, please contact our support team at support@ARMADA.com.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Frequently Asked Questions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Q: How do I book a piece of equipment?\nA: To book a piece of equipment, tap on the "Equipment" tab and select the equipment you want to book. Then, choose a start date and end date for your booking and tap on the "Book Equipment" button. You will receive a confirmation message if your booking is successful.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Q: How do I view my bookings?\nA: To view your bookings, tap on the "Contracts" tab. You will see a list of all your current and past bookings.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Q: How do I cancel a booking?\nA: To cancel a booking, tap on the "Contracts" tab and select the booking you want to cancel. Then, tap on the "Cancel Booking" button.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
