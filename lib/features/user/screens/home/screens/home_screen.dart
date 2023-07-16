import '../../../../../common/widgets/appbar_search_widget.dart';
import '../../../../../common/widgets/dotted_carousel.dart';
import '../../../../../constants/globals.dart';
import '../widgets/address_box.dart';
import '../widgets/deal_of_day_widget.dart';
import '../widgets/top_catergories.dart';
import '../../search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: Globals.appBarGradient),
            ),
            title: AppBarSearchWidget()),
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
