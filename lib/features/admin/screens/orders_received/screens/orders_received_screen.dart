import '../../../services/admin_service.dart';
import '../../../../order/screens/order_detail_screen.dart';
import '../../../../../models/orders.dart';
import 'package:flutter/material.dart';

class OrdersReceivedScreen extends StatefulWidget {
  const OrdersReceivedScreen({super.key});

  @override
  State<OrdersReceivedScreen> createState() => _OrdersReceivedScreenState();
}

class _OrdersReceivedScreenState extends State<OrdersReceivedScreen> {
  List<OrdersModel>? orders;
  final AdminService adminService = AdminService();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    orders = await adminService.fetchAllOrdersReceived(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (orders == null)
        ? const Center(child: CircularProgressIndicator())
        : orders!.isEmpty
            ? const Center(
                child: Text('You haven\'t received any orders yet..'),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final order = orders![index];

                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (order.products.length != 1)
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, OrderDetailScreen.routeName,
                                  arguments: order),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.zero,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12)),
                                child: GridView.builder(
                                    itemCount: order.products.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent:
                                          MediaQuery.of(context).size.width / 2,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      final product = order.products[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.network(product.images[0],
                                            fit: BoxFit.cover),
                                      );
                                    }),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, OrderDetailScreen.routeName,
                                  arguments: order),
                              child: Container(
                                width: double.infinity / 2,
                                margin: EdgeInsets.zero,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12)),
                                child: Image.network(
                                  order.products[0].images[0],
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 5),
                        Text(
                          order.products[0].name,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                  );
                },
                itemCount: orders!.length,
              );
  }
}
