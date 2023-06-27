import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/account/widgets/order_item.dart';
import 'package:commercecart/models/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.products,
  });

  final List<Product>? products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products!.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final product = products![index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 140,
              child: OrderItem(
                img: product.images[0],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(uppercaseFirstLetter(product.name),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.delete_outline))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
