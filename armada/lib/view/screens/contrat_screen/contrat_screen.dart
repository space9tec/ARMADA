import 'package:flutter/material.dart';

class ContractCard extends StatelessWidget {
  final String serviceName;
  final String serviceImage;
  final String day;
  final String userProfile;
  final String status;

  const ContractCard({
    required this.serviceName,
    required this.serviceImage,
    required this.day,
    required this.userProfile,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(serviceImage),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              serviceName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(day),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(userProfile),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(status),
          ),
        ],
      ),
    );
  }
}

class ContractList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildContractCard(
            'John Doe',
            'assets/images/tracter1.png',
            DateTime.now().add(Duration(days: 2)),
            'Service 1',
            'Pending',
            context),
        _buildContractCard(
            'Jane Smith',
            'assets/images/tracter1.png',
            DateTime.now().subtract(Duration(days: 1)),
            'Service 2',
            'Completed',
            context),
        _buildContractCard(
            'Bob Johnson',
            'assets/images/tracter1.png',
            DateTime.now().add(Duration(days: 5)),
            'Service 3',
            'Rejected',
            context),
      ],
    );
  }

  Widget _buildContractCard(String userName, String serviceImage, DateTime date,
      String serviceName, String status, context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/contrat_detail');
      },
      child: SizedBox(
        height: 180,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.greenAccent, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/tracter1.png'),
                ),
                title: Text(userName),
                subtitle: Text(date.toString()),
              ),
              Row(
                children: [
                  Image.asset(
                    serviceImage,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 70.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(serviceName,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.0),
                        Text(status),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContractPage extends StatefulWidget {
  static const String routeName = '/contrat_page';

// till line 19 route code
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return ContractPage();
      },
    );
  }

  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<ContractCard> _contracts = const [
    ContractCard(
      serviceName: 'Service Name 1',
      serviceImage: 'assets/images/tracter1.png',
      day: 'Monday',
      userProfile: 'User Profile 1',
      status: 'Pending',
    ),
    ContractCard(
      serviceName: 'Service Name 2',
      serviceImage: 'assets/images/tracter1.png',
      day: 'Tuesday',
      userProfile: 'User Profile 2',
      status: 'Completed',
    ),
    ContractCard(
      serviceName: 'Service Name 3',
      serviceImage: 'assets/images/tracter1.png',
      day: 'Wednesday',
      userProfile: 'User Profile 3',
      status: 'Rejected',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/display_notification');
            },
            icon: Icon(Icons.notifications_sharp),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      // body: Column(

      body: TabBarView(
        controller: _tabController,
        children: [ContractList(), ContractList(), ContractList()],
      ),
    );
  }
}
