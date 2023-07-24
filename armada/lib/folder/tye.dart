// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Machine Booking',
//       theme: ThemeData(
//         brightness: Brightness.light,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }

// class Machine {
//   final String name;
//   final String category;

//   Machine({required this.name, required this.category});
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Machine> allMachines = [];
//   List<Machine> displayedMachines = [];

//   final TextEditingController _searchController = TextEditingController();
//   bool isSearching = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchMachines();
//   }

//   void fetchMachines() async {
//     // Make the API request to fetch machine data
//     final response =
//         await http.get(Uri.parse('https://your-api-url.com/machines'));

//     if (response.statusCode == 200) {
//       final List<dynamic> machinesData = jsonDecode(response.body);

//       setState(() {
//         allMachines = machinesData.map((machineData) {
//           return Machine(
//             name: machineData['name'],
//             category: machineData['category'],
//           );
//         }).toList();

//         displayedMachines = List.from(allMachines);
//       });
//     } else {
//       // Handle error case here
//       print('Failed to fetch machines. Error: ${response.statusCode}');
//     }
//   }

//   void _performSearch(String searchQuery) {
//     setState(() {
//       if (searchQuery.isEmpty) {
//         displayedMachines = List.from(allMachines);
//       } else {
//         displayedMachines = allMachines.where((machine) {
//           return machine.name
//                   .toLowerCase()
//                   .contains(searchQuery.toLowerCase()) ||
//               machine.category
//                   .toLowerCase()
//                   .contains(searchQuery.toLowerCase());
//         }).toList();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Widget _buildSearchResultsCard() {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16.0),
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Search Results',
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: displayedMachines.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(displayedMachines[index].name),
//                     subtitle: Text(displayedMachines[index].category),
//                     // Add more details or customizations as needed
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Machine Booking'),
//         elevation: 0.0,
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/background_image.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.black.withOpacity(0.5),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: (value) {
//                       setState(() {
//                         isSearching = value.isNotEmpty;
//                       });
//                       _performSearch(value);
//                     },
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                         hintText: 'Search machines...',
//                         hintStyle: TextStyle(color: Colors.white70),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                           borderSide: BorderSide.none,
//                         ),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Colors.white,
//                         ),
//                         suffixIcon: isSearching
//                             ? IconButton(
//                                 icon: Icon(Icons.clear, color: Colors.white),
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   setState(() {
//                                     isSearching = false;
//                                     displayedMachines = List.from(allMachines);
//                                   });
//                                 },
//                               )
//                             : null),
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: allMachines.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(allMachines[index].name),
//                         subtitle: Text(allMachines[index].category),
//                         // Add more details or customizations as needed
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (isSearching)
//             Positioned.fill(
//               child: GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).unfocus();
//                   setState(() {
//                     isSearching = false;
//                   });
//                 },
//                 child: Container(
//                   color: Colors.transparent,
//                 ),
//               ),
//             ),
//           if (isSearching)
//             Positioned(
//               top: 120.0,
//               left: 0,
//               right: 0,
//               child: FractionallySizedBox(
//                 widthFactor: 0.8,
//                 alignment: Alignment.topCenter,
//                 child: _buildSearchResultsCard(),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }
