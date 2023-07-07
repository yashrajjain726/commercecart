import 'package:commercecart/common/widgets/dotted_carousel.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/home/widgets/address_box.dart';
import 'package:commercecart/features/home/widgets/deal_of_day_widget.dart';
import 'package:commercecart/features/home/widgets/top_catergories.dart';
import 'package:commercecart/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: Globals.appBarGradient),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: (value) => Navigator.pushNamed(
                            context, SearchScreen.routeName,
                            arguments: value),
                        decoration: const InputDecoration(
                            hintText: 'Search appliances, mobiles and ...',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(top: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(Icons.search,
                                  color: Colors.black, size: 23),
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBox(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            DottedCarousel(
              images: Globals.carouselImages,
              isDotRequired: false,
            ),
            DealOfDayWidget()
          ],
        ),
      ),
    );
  }
}
