import 'dart:ui';

import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';

class CustomProductItemWidget extends StatefulWidget {
  CustomProductItemWidget({Key? key, this.showUser = true}) : super(key: key);
  bool showUser;

  @override
  State<CustomProductItemWidget> createState() =>
      _CustomProductItemWidgetState();
}

class _CustomProductItemWidgetState extends State<CustomProductItemWidget> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 265,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and profail picture
          widget.showUser == true
              ? InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/itemPage');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            "assets/images/farmer1.png",
                            height: 32,
                            width: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Ethio tracter plc.",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),

          // product image and favorite botton
          Stack(
            children: [
              // Product image
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/itemPage');
                    },
                    child: Image.asset(
                      "assets/images/tracter1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Favorite botton
              Positioned(
                top: 20,
                right: 20,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          favorite = !favorite;
                        });
                      },
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black.withOpacity(0.10),
                              ),
                              child: Center(
                                child: favorite == false
                                    ? const Icon(
                                        Icons.heart_broken,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.favorite,
                                        color: Colors.greenAccent,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // producte name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Trackter vi",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("\$ 34,000",
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              addHorizontalSpace(25),
              Container(
                padding: EdgeInsets.all(1),
                height: 18,
                width: 64,
                decoration: BoxDecoration(color: Colors.green),
                child: Text("Available"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
