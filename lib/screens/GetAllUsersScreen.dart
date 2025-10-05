import 'package:flutter/material.dart';
import 'package:medi_admin_app/screens/UserDetailsScreen.dart';
import 'package:medi_admin_app/viewModel/MyViewModel.dart';
import 'package:provider/provider.dart';

class GetAllUsersScreen extends StatefulWidget {
  const GetAllUsersScreen({super.key});

  @override
  State<GetAllUsersScreen> createState() => _GetAllUsersScreenState();
}

class _GetAllUsersScreenState extends State<GetAllUsersScreen> {
  final Map<String, bool> _switchStates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 20),
          child: Text("All Users", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Consumer<MyViewModel>(
        builder: (context, vm, child) {
          if (vm.getAllUsersState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.getAllUsersState.error != null) {
            return Center(child: Text(vm.getAllUsersState.error.toString()));
          }

          final usersResponse = vm.getAllUsersState.data;

          if (usersResponse == null || usersResponse.message.isEmpty) {
            return const Center(child: Text("No User Found"));
          }

          final data = usersResponse.message;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final response = data[index];
              bool isApproved =
                  _switchStates[response.userId] ??
                  (response.isApproved == 1 ? true : false);

              return Padding(
                padding: const EdgeInsets.only(
                  left: 7,
                  right: 7,
                  top: 7,
                  bottom: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserDetailsScreen(
                              userId: response.userId,
                              userStatus: response.isApproved == 1
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
                              "User Name : ${response.name}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Email : ${response.email}",
                              style: const TextStyle(color: Colors.black38),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Phone : ${response.phoneNumber}",
                              style: const TextStyle(color: Colors.black38),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Text("Pending"),
                                const SizedBox(width: 10),
                                Switch(
                                  value: isApproved,
                                  onChanged: (value) async {
                                    setState(() {
                                      _switchStates[response.userId] = value;
                                    });

                                    if (value) {
                                      vm.approveUser(response.userId, 1);
                                    } else {
                                      vm.approveUser(response.userId, 0);
                                    }
                                  },
                                  activeThumbColor: Colors.green,
                                  inactiveThumbColor: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
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
