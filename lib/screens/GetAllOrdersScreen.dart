import 'package:flutter/material.dart';
import 'package:medi_admin_app/screens/OrderDetailsScreen.dart';
import 'package:provider/provider.dart';

import '../viewModel/MyViewModel.dart';

class GetAllOrdersScreen extends StatefulWidget {
  const GetAllOrdersScreen({super.key});

  @override
  State<GetAllOrdersScreen> createState() => _GetAllOrdersScreenState();
}

class _GetAllOrdersScreenState extends State<GetAllOrdersScreen> {
  // Map to track the switch state for each order by its ID
  final Map<String, bool> _switchStates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 20),
          child: Text("All Orders", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Consumer<MyViewModel>(
        builder: (context, vm, child) {
          if (vm.getAllOrdersState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.getAllOrdersState.error != null) {
            return Center(child: Text(vm.getAllOrdersState.error.toString()));
          }

          final response = vm.getAllOrdersState.data;

          if (response == null || response.message.isEmpty) {
            return const Center(child: Text("No Orders Found"));
          }

          final orders = response.message;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              // Initialize switch state based on isApproved value
              bool isApproved =
                  _switchStates[order.orderId] ??
                  (order.isApproved == 1 ? true : false);

              return Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return OrderDetailsScreen(
                            orderId: order.orderId,
                            orderStatus: order.isApproved == 1
                                ? "Approved"
                                : "Pending",
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User: ${order.userName}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Product: ${order.productName}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Category: ${order.category}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                isApproved ? "Approved" : "Pending",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isApproved ? Colors.green : Colors.red,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Switch(
                                value: isApproved,
                                activeThumbColor: Colors.green,
                                inactiveThumbColor: Colors.red,
                                onChanged: (value) async {
                                  setState(() {
                                    _switchStates[order.orderId] = value;
                                  });

                                  // Here you can call your API to update approval
                                  if (value) {
                                    // User turned it ON → Approve the order
                                    vm.approveOrder(order.orderId, 1);
                                    await vm.addUserStock(
                                      order.productId,
                                      order.productName,
                                      order.quantity.toString(),
                                      order.price.toString(),
                                      order.category,
                                      order.userId,
                                      order.userName,
                                      order.orderId,
                                    );
                                    vm.getUserStock(order.userId);
                                  } else {
                                    vm.approveOrder(order.orderId, 0);
                                    await vm.deleteUserStock(order.orderId);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
