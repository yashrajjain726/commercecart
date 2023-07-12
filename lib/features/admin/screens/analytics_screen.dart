import 'package:commercecart/features/admin/services/admin_service.dart';
import 'package:commercecart/features/admin/widgets/category_products_charts.dart';
import 'package:commercecart/models/analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int? totalEarnings;
  List<Analytics>? sales;
  final AdminService adminService = AdminService();
  @override
  void initState() {
    super.initState();
    getEarningAnalytics();
  }

  getEarningAnalytics() async {
    var response = await adminService.getAdminAnalytics(context: context);
    sales = response['sales'];
    totalEarnings = response['totalEarning'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (totalEarnings == null || sales == null)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Total Sales : \$${totalEarnings!.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Center(
                    child: Container(
                        height: 400,
                        child: CategoryProductChart(sales: sales!)))
              ],
            ),
          );
  }
}
