import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/home/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({super.key});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: Globals.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final categoryName = Globals.categoryImages[index]['title'];
          final image = Globals.categoryImages[index]['image'];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CategoryScreen.routeName,
                  arguments: categoryName);
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        image!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      )),
                ),
                const SizedBox(height: 5),
                Text(
                  categoryName!,
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
