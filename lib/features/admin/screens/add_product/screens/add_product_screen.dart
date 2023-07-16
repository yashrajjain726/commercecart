import 'dart:io';

import 'package:commercecart/common/ui_widgets/custom_textfield.dart';

import '../../../../../common/ui_widgets/custom_button.dart';
import '../../../../../common/widgets/custom_textformfield.dart';
import '../../../../../common/widgets/dotted_carousel.dart';
import '../../../../../constants/globals.dart';
import '../../../../../constants/utils.dart';
import '../../../services/admin_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add/product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AdminService adminServices = AdminService();
  List<File> images = [];
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

  addProduct() {
    if (_formKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.addProduct(
          context: context,
          images: images,
          name: _nameController.text,
          description: _descController.text,
          price: int.parse(_priceController.text),
          quantity: int.parse(_qntyController.text),
          category: category);
    }
  }

  void selectImages() async {
    var result = await pickImages();
    setState(() {
      images = result;
    });
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
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    (images.isEmpty)
                        ? GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
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
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : DottedCarousel(
                            imagesPath: images,
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                        controller: _nameController,
                        text: 'Product Name',
                        hintText: 'Enter product name',
                        validator: (value) => checkNullAndEmpty(value, 'name')),
                    const SizedBox(height: 5),
                    CustomTextField(
                        height: 120,
                        maxLines: 7,
                        controller: _descController,
                        text: 'Description ',
                        hintText: 'Enter product description',
                        validator: (value) =>
                            checkNullAndEmpty(value, 'description')),
                    const SizedBox(height: 5),
                    CustomTextField(
                        controller: _priceController,
                        text: 'Price',
                        hintText: '1000.00',
                        validator: (value) =>
                            checkNullAndEmpty(value, 'price')),
                    CustomTextField(
                        controller: _qntyController,
                        text: 'Quantity',
                        hintText: '2000',
                        validator: (value) =>
                            checkNullAndEmpty(value, 'quantity')),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Category'),
                        const SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: DropdownButton(
                            onChanged: (value) {
                              setState(() {
                                category = value!;
                              });
                            },
                            value: category,
                            icon: Container(
                                alignment: Alignment.centerRight,
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                )),
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
                  ],
                ),
              ))),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          child: CustomButton(
              text: 'Add Product ',
              onPressed:
                  (images.isEmpty) ? showRequiredImagesBar : addProduct)),
    );
  }

  showRequiredImagesBar() {
    showSnackbar(context, 'Product Images are required to be added');
  }
}
