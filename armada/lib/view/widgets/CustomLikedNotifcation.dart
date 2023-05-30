import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomLikedNotifcation extends StatelessWidget {
  const CustomLikedNotifcation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Stack(children: const [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 25,
                // backgroundImage: AssetImage("assets/imges/Avatar3.png"),
              ),
            ),
            Positioned(
              bottom: 10,
              child: CircleAvatar(
                radius: 25,
                // backgroundImage: AssetImage("assets/imges/Avatar2.png"),
              ),
            ),
          ]),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                maxLines: 2,
                text: TextSpan(
                    text: "Sala",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: " and \n",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const TextSpan(text: "Eyu")
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Liked your recipe  .  h1",
                  style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        ),
        Image.asset(
          "assets/images/avatar_profile.png",
          height: 64,
          width: 64,
        ),
      ],
    );
  }
}
