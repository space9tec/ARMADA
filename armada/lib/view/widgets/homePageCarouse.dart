import 'package:flutter/material.dart';
Column homePageCarousel(BuildContext context) {
late PageController _pageController;
  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];
int activePage=1;
  @override
  void initState() {
    //super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }




    return Column(
              children: [
                SizedBox(
                   width: MediaQuery.of(context).size.width,
                   height: 200,
                    child: PageView.builder(
                    itemCount: images.length,

                      controller: _pageController,
                      onPageChanged: (page) {
                      setState(() {
                   activePage = page;
                });
      },
                    pageSnapping: true,

                    itemBuilder: (context,pagePosition){
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Image.network(images[pagePosition]));
                  }),
                ),
               
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(images.length,activePage))


              ],
            );
  }
  
  void setState(Null Function() param0) {
  }
   List<Widget> indicators(imagesLength,currentIndex) {
                      return List<Widget>.generate(imagesLength, (index) {
                        return Container(
                           margin: EdgeInsets.all(3),
                          width: 10,
                        height: 10,
                    decoration: BoxDecoration(
                        color: currentIndex == index ? Colors.black : Colors.black26,
                        shape: BoxShape.circle),
                  );
                });
              }
