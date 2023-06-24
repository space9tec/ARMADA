import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SearchScreen(),
    );
  }

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  static List previousSearchs = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Search Bar
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.green,
                        )),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (pure) {
                              setState(() {});
                            },
                            onEditingComplete: () {
                              previousSearchs.add(searchController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            },
                            controller: searchController,
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
                              suffixIcon: searchController.text.isEmpty
                                  ? null
                                  : Icon(Icons.search),
                              // onTapSuffixIcon: () {
                              //   searchController.clear();
                              // },
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (context) =>
                                    _custombottomSheetFilter(context));
                          });
                        },
                        icon: const Icon(
                          Icons.filter_list_sharp,
                          color: Colors.green,
                        )),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Container(
              color: Colors.white,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: previousSearchs.length,
                  itemBuilder: (context, index) => previousSearchsItem(index)),
            ),
            const SizedBox(
              height: 8,
            ),

            // Search Suggestions
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search Suggestions",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      searchSuggestionsTiem("harvestor"),
                      searchSuggestionsTiem("tractor"),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      searchSuggestionsTiem("combiner"),
                      searchSuggestionsTiem("attachments"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            previousSearchs.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                Icons.timer_3_select,
                color: Colors.greenAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(previousSearchs[index],
                  style: Theme.of(context).textTheme.bodyLarge),
              const Spacer(),
              const Icon(
                Icons.call_made_outlined,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }

  searchSuggestionsTiem(String text) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(30)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  _custombottomSheetFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Add a Filter",
            style: Theme.of(context).textTheme.headline2,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Cancel",
                color: Colors.black,
                textColor: Colors.white,
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
                text: "Done",
              ))
            ],
          )
        ],
      ),
    );
  }
}
