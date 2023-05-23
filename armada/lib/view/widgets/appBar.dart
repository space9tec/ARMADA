import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
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
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 90,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            style: const TextStyle(
              color: Colors.grey,
            ),
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 10, 190, 106),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.green,
                  )),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.green,
                ),
              ),
              suffixIcon: Container(
                margin: EdgeInsets.all(7),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                    child: Icon(
                  Icons.filter_list_sharp,
                  color: Colors.white,
                )),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
