import 'package:flutter/material.dart';
import 'package:medi_admin_app/viewModel/MyViewModel.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productName = TextEditingController();
  final TextEditingController productCategory = TextEditingController();
  final TextEditingController productPrize = TextEditingController();
  final TextEditingController productStock = TextEditingController();

  @override
  void dispose() {
    productName.clear();
    productCategory.clear();
    productPrize.clear();
    productStock.clear();
    super.dispose();
  }

  void _addProduct(BuildContext context) async {
    final vm = Provider.of<MyViewModel>(context, listen: false);

    await vm.addProducts(
      productName.text.trim(),
      productCategory.text.trim(),
      productPrize.text.trim(),
      productStock.text.trim(),
    );

    if (vm.addProductState.data != null) {
      print(vm.addProductState.data?.message);
      _clearFields();
    }
  }

  void _clearFields() {
    productName.clear();
    productPrize.clear();
    productStock.clear();
    productCategory.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Text("Add Product", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Consumer<MyViewModel>(
        builder: (context, vm, child) {
          if (vm.addProductState.error != null) {
            return Center(child: Text(vm.addProductState.error.toString()));
          }
          if (vm.addProductState.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (vm.addProductState.data != null) {
            print("Login Success: ${vm.addProductState.data?.message}");
          }
          return Padding(
            padding: EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: productName,
                  hintText: 'Enter product Name',
                  keyBoardType: TextInputType.text,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: productCategory,
                  hintText: 'Enter product Category',
                  keyBoardType: TextInputType.text,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: productPrize,
                  hintText: 'Enter product Prize',
                  keyBoardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: productStock,
                  hintText: 'Enter product Stock',
                  keyBoardType: TextInputType.number,
                ),
                SizedBox(height: 20),

                SizedBox(
                  width: 200,
                  height: 50,
                  child: MaterialButton(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () {
                      _addProduct(context);
                    },
                    child: Text(
                      "Add product",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyBoardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyBoardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      ),
    );
  }
}
