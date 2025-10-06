import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medi_admin_app/common/Constants.dart';
import 'package:medi_admin_app/models/AddProductResponse.dart';
import 'package:medi_admin_app/models/GetAllOrdersResponse.dart';
import 'package:medi_admin_app/models/GetAllUsersResponse.dart';
import 'package:medi_admin_app/models/GetSpecificOrderModel.dart';
import 'package:medi_admin_app/models/GetSpecificUserResponse.dart';

import '../models/GetUserStockResponse.dart';

class Repo {
  Future<GetAllUsersResponse> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse("$BASE_URL$GET_ALL_USERS_ENDPOINT"),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return GetAllUsersResponse.fromJson(json);
      } else {
        throw Exception("Empty system ");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AddProductResponse> addProduct(
    String productName,
    String productCategory,
    String productPrize,
    String productStock,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$ADD_PRODUCT_ENDPOINT"),
        body: {
          "name": productName,
          "category": productCategory,
          "price": productPrize,
          "stock": productStock,
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return AddProductResponse.fromJson(json);
      } else {
        throw Exception("empty");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetAllOrdersResponse> getAllOrders() async {
    try {
      final response = await http.get(
        Uri.parse("$BASE_URL$GET_ALLORDERS_ENDPOINT"),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return GetAllOrdersResponse.fromJson(json);
      } else if (response.statusCode == 400) {
        throw Exception("Not found");
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AddProductResponse> approveOrder(
    String orderId,
    int isApproved,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse("$BASE_URL$APPROVE_ORDER_ENDPOINT"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"orderId": orderId, "isApproved": isApproved.toString()},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return AddProductResponse.fromJson(json);
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AddProductResponse> addUserStock(
    String productId,
    String productName,
    String stock,
    String price,
    String category,
    String userId,
    String userName,
    String stockId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$ADD_STOCK_ENDPOINT"),

        body: {
          "product_id": productId,
          "product_name": productName,
          "stock": stock,
          "price": price,
          "category": category,
          "user_id": userId,
          "user_name": userName,
          "stock_id": stockId,
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return AddProductResponse.fromJson(json);
      } else {
        print("from repo approveOrder error: ${response.statusCode}");
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      print("from repo addUserStock error: ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<AddProductResponse> deleteStock(String stockId) async {
    try {
      final response = await http.delete(
        Uri.parse("$BASE_URL$DELETE_STOCK_ENDPOINT"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},

        body: {"stockId": stockId},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return AddProductResponse.fromJson(json);
      } else {
        print("from repo approveOrder error: ${response.statusCode}");
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      print("from repo addUserStock error: ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<AddProductResponse> approveUser(String userId, int isApproved) async {
    try {
      final response = await http.patch(
        Uri.parse("$BASE_URL$APPROVE_USER_ENDPOINT"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},

        body: {"user_id": userId, "isApproved": isApproved.toString()},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return AddProductResponse.fromJson(json);
      } else {
        print("from repo approveOrder error: ${response.statusCode}");
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      print("from repo addUserStock error: ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<GetSpecificOrderModel> getSpecificOrder(String orderId) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$GET_SPECIFICORDER_ENDPOINT"),

        body: {"orderId": orderId},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return GetSpecificOrderModel.fromJson(json);
      } else {
        print("from repo approveOrder error: ${response.statusCode}");
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      print("from repo addUserStock error: ${e.toString()}");
      throw Exception(e.toString());
    }
  }



  Future<GetSpecificUserResponse> getSpecificUser(String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$GET_SPECIFICUser_ENDPOINT"),

        body: {"user_id": userId},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return GetSpecificUserResponse.fromJson(json);
      } else {
        print("from repo approveOrder error: ${response.statusCode}");
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      print("from repo addUserStock error: ${e.toString()}");
      throw Exception(e.toString());
    }
  }



  Future<AddProductResponse> deleteOrder(String orderId) async {
    try {
      final response = await http.delete(
        Uri.parse("$BASE_URL$DELETE_SPECIFICORDER_ENDPOINT"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},

        body: {"orderId":orderId},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return AddProductResponse.fromJson(json);
      } else {
        print("from repo approveOrder error: ${response.statusCode}");
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      print("from repo addUserStock error: ${e.toString()}");
      throw Exception(e.toString());
    }
  }



  Future<AddProductResponse> deleteUser(String userId) async {
    try {
      final response = await http.delete(
        Uri.parse("$BASE_URL$DELETE_SPECIFICUSER_ENDPOINT"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},

        body: {"user_id":userId},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return AddProductResponse.fromJson(json);
      } else {
        print("from repo approveOrder error: ${response.statusCode}");
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      print("from repo addUserStock error: ${e.toString()}");
      throw Exception(e.toString());
    }
  }


  Future<GetUserStockResponse> getAllStock(String userId)
  async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$GET_USERSTOCK_ENDPOINT"),

        body: {"user_id": userId},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return GetUserStockResponse.fromJson(json);
      } else if (response.statusCode == 400) {
        throw Exception("Not found");
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}
