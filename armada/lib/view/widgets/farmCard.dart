import 'package:armada/networkhandler.dart';
import 'package:flutter/material.dart';

import '../../models/farm.dart';

class BlogCard extends StatelessWidget {
  const BlogCard(
      {required key, required this.farmlist, required this.networkHandler})
      : super(key: key);

  final FarmM farmlist;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Stack(
          children: <Widget>[
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         // image: networkHandler.getImage(addBlogModel.id),
            //         image: AssetImage(""),
            //         fit: BoxFit.fill),
            //   ),
            // ),
            Positioned(
              bottom: 2,
              child: Container(
                padding: EdgeInsets.all(7),
                height: 60,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  // uploadFarm.name,
                  farmlist.farmname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
