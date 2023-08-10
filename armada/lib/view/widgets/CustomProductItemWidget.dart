import 'package:flutter/material.dart';

import '../../models/model.dart';
import '../../utils/helper_widget.dart';
import '../screens/screens.dart';

class CustomProductItemWidget extends StatefulWidget {
  final MachineM machine;

  const CustomProductItemWidget(this.machine, {Key? key}) : super(key: key);

  @override
  State<CustomProductItemWidget> createState() =>
      _CustomProductItemWidgetState();
}

class _CustomProductItemWidgetState extends State<CustomProductItemWidget> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.symmetric(),
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: ((context) => ItemPage(machine: widget.machine)),
          //         ));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //     child: Row(
          //       children: [
          //         ClipRRect(
          //           borderRadius: BorderRadius.circular(2),
          //           clipBehavior: Clip.antiAlias,
          //           child: Image.asset(
          //             "assets/images/farmer_profile.png",
          //             height: 32,
          //             width: 32,
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         Text(
          //           widget.machine.manufacturer,
          //           style: Theme.of(context).textTheme.bodySmall,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          Stack(
            children: [
              SizedBox(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) =>
                              ItemPage(machineid: widget.machine.machineId)),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.02)),
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://armada-server.glitch.me/api/machinery/image/${widget.machine.imageFile}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // ),
              // Favorite botton
              // Positioned(
              //   top: 20,
              //   right: 20,
              //   child: Stack(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           setState(() {
              //             favorite = !favorite;
              //           });
              //         },
              //         child: ClipRRect(
              //           clipBehavior: Clip.hardEdge,
              //           child: Container(
              //             clipBehavior: Clip.hardEdge,
              //             width: 32,
              //             height: 32,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(7)),
              //             child: BackdropFilter(
              //               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //               child: Container(
              //                 width: 32,
              //                 height: 32,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(5),
              //                   color: Colors.black.withOpacity(0.10),
              //                 ),
              //                 child: Center(
              //                   child: favorite == false
              //                       ? const Icon(
              //                           Icons.heart_broken,
              //                           color: Colors.white,
              //                         )
              //                       : const Icon(
              //                           Icons.favorite,
              //                           color: Colors.greenAccent,
              //                         ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),

          // producte name
          Container(
              child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.machine.type,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Model",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.machine.model,
                  ),
                ),
              ],
            ),
            // Text(widget.machine.model),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" ${widget.machine.year}",
                      style: Theme.of(context).textTheme.bodyMedium),
                  // ),
                  addHorizontalSpace(25),
                  // Container(

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: MediaQuery.of(context).size.height * 0.025,
                    // width: MediaQuery.of(context).size.width * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.green,
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.machine.status,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  // Text(widget.machine.status),
                  // ),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}
