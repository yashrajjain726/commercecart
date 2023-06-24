import 'package:commercecart/common/widgets/custom_button.dart';
import 'package:commercecart/common/widgets/custom_textformfield.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add/product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _qntyController = TextEditingController();
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  String category = 'Mobiles';
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _qntyController.dispose();
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
            title: const Text('Add Product',
                style: TextStyle(color: Colors.white))),
      ),
      body: SingleChildScrollView(
          child: Form(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [10, 4],
              strokeCap: StrokeCap.round,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.folder_open, size: 40),
                    const SizedBox(height: 15),
                    Text(
                      'Select Product Images',
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextFormField(
              validator: (value) {},
              controller: _nameController,
              hintText: 'Product Name',
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              validator: (value) {},
              controller: _descController,
              hintText: 'Description',
              maxLines: 7,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              validator: (value) {},
              controller: _priceController,
              hintText: 'Price',
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              validator: (value) {},
              controller: _qntyController,
              hintText: 'Quantity',
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
                value: category,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: productCategories
                    .map((String item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ))),
      bottomNavigationBar: Container(
          margin:
              const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 50),
          child: CustomButton(text: 'Sell', onPressed: () {})),
    );
  }
}
