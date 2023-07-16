import 'package:commercecart/models/product.dart';

import '../../../../user/screens/account/widgets/order_item.dart';
import '../../../../../constants/utils.dart';
import '../../../services/admin_service.dart';
import '../../../../../providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListingItem extends StatefulWidget {
  const ProductListingItem({
    super.key,
    required this.product,
    required this.index,
  });

  final Product product;
  final int index;

  @override
  State<ProductListingItem> createState() => _ProductListingItemState();
}

class _ProductListingItemState extends State<ProductListingItem> {
  final AdminService adminServices = AdminService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 120,
          child: widget.product.images.isEmpty
              ? null
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Container(
                      width: 180,
                      padding: const EdgeInsets.all(10),
                      child: Image.network(
                        widget.product.images[0],
                        fit: BoxFit.fitHeight,
                        width: 180,
                      ),
                    ),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(uppercaseFirstLetter(widget.product.name),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                  onPressed: () async {
                    await adminServices
                        .deleteProduct(context, widget.product.id!, () {
                      context
                          .read<ProductProvider>()
                          .deleteProduct(widget.index);
                    });
                  },
                  icon: const Icon(Icons.delete_outline))
            ],
          ),
        )
      ],
    );
  }
}
