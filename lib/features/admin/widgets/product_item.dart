import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/account/widgets/order_item.dart';
import 'package:commercecart/features/admin/services/admin_service.dart';
import 'package:commercecart/models/product.dart';
import 'package:commercecart/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final AdminService adminServices = AdminService();
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return GridView.builder(
      itemCount: products.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final product = products[index];

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              child: product.images.isEmpty
                  ? null
                  : OrderItem(
                      img: product.images[0],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(uppercaseFirstLetter(product.name),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                      onPressed: () async {
                        await adminServices.deleteProduct(context, product.id!,
                            () {
                          context.read<ProductProvider>().deleteProduct(index);
                        });
                      },
                      icon: const Icon(Icons.delete_outline))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
