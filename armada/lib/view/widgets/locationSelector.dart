import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/location_drop_down.dart';

Widget locationSelector(BuildContext context) {
  return Container(

    
   // width: MediaQuery.of(context).size.width*0.3,
    // child: Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     SizedBox(
    //       width: MediaQuery.of(context).size.width - 322,
    //       // padding: EdgeInsets.only(right: 28.0),
    //       child: Text(
    //         "Account",
    //         style: Theme.of(context).textTheme.titleMedium,
    //       ),
    //     ),
     child: Consumer<LocationSelectorProvider>(
          builder: (context, value, child) =>
            SizedBox(
                     width: MediaQuery.of(context).size.width - 200,
                     //  height: 65,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                           // width: MediaQuery.of(context).size.width *0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButtonFormField(
                  value: value.selectedLocation,
                  items: value.location
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(e),
                            ),
                          ))
                      .toList(),
                    onChanged: (val) {
                    value.setLocation(val);
                  },
                  decoration: InputDecoration(border: InputBorder.none, 
                                 contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.white,
                  
                          
                  enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.green,
                                  ),
                                ),
                  ),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down_circle_sharp,
                    color: Colors.green,
                  ),
                ),
                        ),
              ),
            ),
        ),
      //],
    );
 // );
}
