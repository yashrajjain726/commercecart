// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commercecart/common/widgets/appbar_search_widget.dart';
import 'package:commercecart/common/widgets/custom_button.dart';
import 'package:commercecart/features/admin/services/admin_service.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/models/orders.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrdersModel order;
  static const routeName = '/order-detail';
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int _currentStep = 0;
  final AdminService adminService = AdminService();

  @override
  void initState() {
    super.initState();
    _currentStep = widget.order.status;
  }

  changeOrderStatusAsAdmin() {
    adminService.changeOrderStatus(
        context: context, order: widget.order, onSuccess: () {});
    setState(() {
      _currentStep += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
              flexibleSpace: Container(
                decoration:
                    const BoxDecoration(gradient: Globals.appBarGradient),
              ),
              title: context.watch<UserProvider>().user.type == "admin"
                  ? const Text('Order Details')
                  : const AppBarSearchWidget()),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View Order details',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order date: ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}',
                      ),
                      Text(
                        'Order ID: ${widget.order.id}',
                      ),
                      Text(
                        'Order Total: \$${widget.order.totalPrice.toDouble()}',
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Purchase details',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.order.products.length; i++)
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  widget.order.products[i].images[0],
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.order.products[i].name,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    'Quantity: ${widget.order.quantity[i].toString()}',
                                  )
                                ],
                              ))
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Tracking',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: Stepper(
                        currentStep: _currentStep,
                        controlsBuilder: (context, details) {
                          if (user.type != "user") {
                            return CustomButton(
                                text: const Text('Done '),
                                onPressed: changeOrderStatusAsAdmin);
                          }
                          return const SizedBox.shrink();
                        },
                        steps: [
                          Step(
                              title: const Text('Pending'),
                              isActive: _currentStep > 0,
                              state: _currentStep > 0
                                  ? StepState.complete
                                  : StepState.indexed,
                              content: const Text(
                                  'Your order is yet to be delivered..')),
                          Step(
                              title: const Text('Completed'),
                              isActive: _currentStep > 1,
                              state: _currentStep > 1
                                  ? StepState.complete
                                  : StepState.indexed,
                              content: const Text(
                                  'Your order has been delivered, you are yet to verify using OTP')),
                          Step(
                              isActive: _currentStep > 2,
                              state: _currentStep > 2
                                  ? StepState.complete
                                  : StepState.indexed,
                              title: const Text('Received'),
                              content: const Text(
                                  'Your order has been delivered and verified by you')),
                          Step(
                              isActive: _currentStep >= 3,
                              state: _currentStep >= 3
                                  ? StepState.complete
                                  : StepState.indexed,
                              title: const Text('Delivered'),
                              content: const Text(
                                  'Your order has been delivered and verified by you..'))
                        ])),
              ],
            ),
          ),
        ));
  }
}
