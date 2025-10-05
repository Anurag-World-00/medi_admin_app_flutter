import 'package:flutter/material.dart';
import 'package:medi_admin_app/viewModel/MyViewModel.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  final String userId;
  final String userStatus;

  const UserDetailsScreen({
    super.key,
    required this.userId,
    required this.userStatus,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();

    final vm = context.read<MyViewModel>();

    vm.getSpecificUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Padding(
        padding: EdgeInsets.only(left:5,right: 5,top: 5,bottom: 20),
        child: Text("Specific User", style: TextStyle(color: Colors.white)),
      ),
        backgroundColor: Colors.lightBlueAccent,
    ),
      body: Consumer<MyViewModel>(
        builder: (context, vm, _) {
          if (vm.getSpecificUserState.error != null) {
            return Center(
              child: Text(vm.getSpecificUserState.error.toString()),
            );
          }
          if (vm.getSpecificUserState.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          final orderResponse = vm.getSpecificUserState.data;

          if (orderResponse == null) {
            return Text("empty");
          }
          final response = orderResponse.message;

          return Center(
            child: Card(
              elevation: 6,
              color: Colors.blue.shade50,
              // light background theme
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
                        "User Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent.shade700,
                        ),
                      ),
                    ),
                    const Divider(),
                    buildDetail("user-id:", response!.userId.toString()),
                    buildDetail("Name:", response.name.toString()),
                    buildDetail("Email:", response.email.toString()),
                    buildDetail("Phone:", response.phoneNumber.toString()),
                    buildDetail("Address:", response.address.toString()),
                    buildDetail("Pincode:", response.pinCode.toString()),
                    buildDetail("Password:", response.password.toString()),
                    buildDetail(
                      "Account Created:",
                      response.dateOfAccountCreation.toString(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          widget.userStatus,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.userStatus == "Approved"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        Icon(
                          widget.userStatus == "Approved"
                              ? Icons.check
                              : Icons.close,
                          color: widget.userStatus == "Approved"
                              ? Colors.green
                              : Colors.red,
                        ),
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
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () async {
                          await vm.deleteSpecificUser(widget.userId);
                          vm.getAllUsers();
                          Navigator.pop(context);
                          // Delete user action
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
        },
      ),
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
