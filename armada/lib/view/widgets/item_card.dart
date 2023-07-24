import 'package:armada/configuration/theme_manager.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.name, required this.price});

  final String name;
  final String price;
  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late CustomTheme customTheme;
  // late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    // fetchData();
    customTheme = CustomTheme();

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              fit: BoxFit.scaleDown,
              height: 100,
              "assets/images/tracter1.png",
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    // style: textTheme.displayMedium,
                  ),
                  Text(
                    widget.price,
                    // style: textTheme.displaySmall,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
