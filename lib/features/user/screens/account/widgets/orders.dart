import '../../../../admin/order_detail_screen.dart';
import '../../../services/user_service.dart';
import '../../../../../models/orders.dart';
import 'order_item.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrdersModel>? orders;
  final UserService userService = UserService();
  @override
  void initState() {
    super.initState();
    fetchOrderedProducts();
  }

  fetchOrderedProducts() async {
    orders = await userService.fetchUserOrderedProducts(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : orders!.isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Your Orders',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: TextButton(
                            onPressed: () {}, child: const Text('See all')),
                      )
                    ],
                  ),
                  Container(
                    height: 170,
                    padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, OrderDetailScreen.routeName,
                              arguments: orders![index]),
                          child: OrderItem(
                              img: orders![index].products[0].images[0]),
                        );
                      },
                    ),
                  )
                ],
              );
  }
}
