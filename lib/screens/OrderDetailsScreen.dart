import 'package:flutter/material.dart';
import 'package:medi_admin_app/viewModel/MyViewModel.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final String orderStatus;
  const OrderDetailsScreen({super.key, required this.orderId, required this.orderStatus});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  @override
  void initState() {

    super.initState();

    final vm = Provider.of<MyViewModel>(context,listen: false);
    vm.getSpecificOrder(widget.orderId);

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title:    const Padding(
            padding: EdgeInsets.only(left:5,right: 5,top: 5,bottom: 20),
            child: Text("Specific Order", style: TextStyle(color: Colors.white)),
          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body:    Consumer<MyViewModel>(builder: (context,vm,_){


          if(vm.getSpecificOrderState.error != null){
            return Center(child: Text(vm.getSpecificOrderState.error.toString()),);
          }if(vm.getSpecificOrderState.isLoading){
            return Center(child: CircularProgressIndicator(),);

          }
          final orderResponse = vm.getSpecificOrderState.data;

          if(orderResponse == null){
            return Text("empty");
          }
          final response =  orderResponse.message;






          return Center(
            child: Card(
              elevation: 6,
              color: Colors.blue.shade50, // light background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Order Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent.shade700,
                        ),
                      ),
                    ),
                    const Divider(),
                    buildDetail("user-id:", response!.userId!.toString()),
                    buildDetail("id:", response.id.toString()),
                    buildDetail("order-id:", response.orderId.toString()),
                    buildDetail("User-Name:", response.userName.toString()),
                    buildDetail("Message:", response.message.toString()),
                    buildDetail("Category:", response.category.toString()),
                    buildDetail("Product-Name:", response.productName.toString()),
                    buildDetail("Product-id:", response.productId.toString()),
                    buildDetail("Order Created:", response.dateOfOrderCreation.toString()),
                    buildDetail("Quantity:", response.quantity.toString()),
                    buildDetail("Price:", response.price.toString()),
                    buildDetail("Total Amount:", response.totalAmount.toString()),
                     SizedBox(height: 10),

                    Row(
                      children:  [
                        Text(

                          widget.orderStatus,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.orderStatus =="Approved" ? Colors.green : Colors.red,
                          ),
                        ),
                        Icon(widget.orderStatus =="Approved" ? Icons.check : Icons.close , color: widget.orderStatus =="Approved" ? Colors.green : Colors.red,),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        onPressed: () async{
                        await vm.deleteSpecificOrder(widget.orderId);
                        vm.getAllOrders();
                        Navigator.pop(context);

                        },
                        child: const Text(
                          "Delete User",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );







        })
      );
  }





  Widget buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          text: "$label ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
