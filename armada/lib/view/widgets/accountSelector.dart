import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/drop_down_provider.dart';

Widget accountSelector(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width - 120,
    child: Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 322,
          // padding: EdgeInsets.only(right: 28.0),
          child: Text(
            "Account ",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Consumer<DropDownProvider>(
          builder: (context, value, child) => Container(
            width: MediaQuery.of(context).size.width - 210,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButtonFormField(
              value: value.selectedAccount,
              items: value.accountType
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(e),
                        ),
                      ))
                  .toList(),
              onChanged: (val) {
                value.setAccountType(val);
              },
              decoration: InputDecoration(border: InputBorder.none),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.grey,
              ),
              icon: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.arrow_drop_down_circle_sharp,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
