import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class AddFarm extends StatefulWidget {
  static const String routeName = '/add_farm';

// till line 19 route code
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const AddFarm();
      },
    );
  }

  const AddFarm({Key? key}) : super(key: key);

  @override
  State<AddFarm> createState() => _AddFarmState();
}

class _AddFarmState extends State<AddFarm> {
  final TextEditingController _Numbercontroller = TextEditingController();
  final TextEditingController _Emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();
  List ingrediants = [1];
  List steps = [1];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Cancel",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )),
                        Text(
                          "2/2",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ingrediant",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton.icon(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.blueGrey)),
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            label: const Text("Group"))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ingrediants.length,
                        itemBuilder: (context, index) =>
                            enterIngerediant(index)),
                    ingrediantsButton(),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Steps",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                steps.add(step(1));
                              });
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: steps.length,
                      itemBuilder: (context, index) => step(index),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          text: "Back",
                          color: Colors.brown,
                          textColor: Colors.blue,
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: CustomButton(
                                onTap: () {
                                  openDialog();
                                },
                                text: "Next")),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// enter engrediant section
  enterIngerediant(int index) {
    return Dismissible(
      key: GlobalKey(),
      direction: ingrediants.length > 1
          ? DismissDirection.endToStart
          : DismissDirection.none,
      onDismissed: (direction) {
        setState(() {
          ingrediants.removeAt(index);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: InputText(context, "Full name", "abebe", false,
            Icons.person_3_sharp, TextInputType.name, _userNamecontroller),
      ),
    );
  }

  ingrediantsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          setState(() {});
          ingrediants.add(enterIngerediant(1));
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.green),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add),
              Text(
                "Ingrediant",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  step(int index) {
    return Dismissible(
      direction: steps.length > 1
          ? DismissDirection.endToStart
          : DismissDirection.none,
      key: GlobalKey(),
      onDismissed: (d) {
        setState(() {
          steps.removeAt(index);
        });
      },
      child: Stack(
        children: [
          Column(
            children: [
              InputText(
                  context,
                  "Full name",
                  "abebe",
                  false,
                  Icons.person_3_sharp,
                  TextInputType.name,
                  _userNamecontroller),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 35),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 12,
              child: Text(
                "${index + 1}",
                style: TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                padding: const EdgeInsets.all(20),
                height: 400,
                width: 327,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/imges/image 8.png"),
                    Text(
                      "Upload sucsess",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "Your recipe has benn uploaded",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      "You can see it in your Profile",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    CustomButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FarmScreen()));
                        },
                        text: "Back to Home")
                  ],
                ),
              ),
            ));
  }
}
