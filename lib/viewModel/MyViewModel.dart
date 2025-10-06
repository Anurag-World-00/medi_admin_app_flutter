import 'package:flutter/cupertino.dart';
import 'package:medi_admin_app/common/UiState.dart';
import 'package:medi_admin_app/models/AddProductResponse.dart';
import 'package:medi_admin_app/models/GetAllOrdersResponse.dart';
import 'package:medi_admin_app/models/GetAllUsersResponse.dart';
import 'package:medi_admin_app/models/GetSpecificOrderModel.dart';
import 'package:medi_admin_app/models/GetSpecificUserResponse.dart';
import 'package:medi_admin_app/repo/repo.dart';

import '../models/GetUserStockResponse.dart';

class MyViewModel extends ChangeNotifier {
  final _repo = Repo();

  UiState<GetAllUsersResponse> _getAllUsersState = UiState.idle();

  UiState<GetAllUsersResponse> get getAllUsersState => _getAllUsersState;

  UiState<AddProductResponse> _addProductState = UiState.idle();

  UiState<AddProductResponse> get addProductState => _addProductState;

  UiState<GetAllOrdersResponse> _getAllOrdersState = UiState.idle();

  UiState<GetAllOrdersResponse> get getAllOrdersState => _getAllOrdersState;

  UiState<AddProductResponse> _approveOrderState = UiState.idle();

  UiState<AddProductResponse> get approveOrderState => _approveOrderState;

  UiState<AddProductResponse> _addUserStockState = UiState.idle();

  UiState<AddProductResponse> get addUserStockState => _addUserStockState;

  UiState<AddProductResponse> _deleteUserStockState = UiState.idle();

  UiState<AddProductResponse> get deleteUserStockState => _deleteUserStockState;

  UiState<AddProductResponse> _approveUserState = UiState.idle();

  UiState<AddProductResponse> get approveUserState => _approveUserState;

  UiState<GetSpecificOrderModel> _getSpecificOrderState = UiState.idle();

  UiState<GetSpecificOrderModel> get getSpecificOrderState =>
      _getSpecificOrderState;

  UiState<GetSpecificUserResponse> _getSpecificUserState = UiState.idle();

  UiState<GetSpecificUserResponse> get getSpecificUserState =>
      _getSpecificUserState;

  UiState<GetUserStockResponse> _getUserStockState = UiState.idle();

  UiState<GetUserStockResponse> get getUserStockState => _getUserStockState;




  UiState<AddProductResponse> _deleteSpecificOrderStatus = UiState.idle();

  UiState<AddProductResponse> get deleteSpecificOrderStatus => _deleteSpecificOrderStatus;


  UiState<AddProductResponse> _deleteSpecificUserState = UiState.idle();

  UiState<AddProductResponse> get deleteSpecificUserState => _deleteSpecificUserState;


  MyViewModel() {
    getAllUsers();
    getAllOrders();
  }

  Future<void> getAllUsers() async {
    _getAllUsersState = UiState.loading();
    notifyListeners();

    try {
      final response = await _repo.getAllUsers();
      _getAllUsersState = UiState.success(response);
      notifyListeners();
    } catch (e) {
      _getAllUsersState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> addProducts(
    String productName,
    String productCategory,
    String productPrize,
    String productStock,
  ) async {
    _addProductState = UiState.loading();
    notifyListeners();

    try {
      final response = await _repo.addProduct(
        productName,
        productCategory,
        productPrize,
        productStock,
      );

      _addProductState = UiState.success(response);
      getAllOrders();
      notifyListeners();
    } catch (e) {
      _addProductState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> getAllOrders() async {
    _getAllOrdersState = UiState.loading();
    notifyListeners();
    try {
      final data = await _repo.getAllOrders();
      _getAllOrdersState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _getAllOrdersState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> approveOrder(String orderId, int isApproved) async {
    _approveOrderState = UiState.loading();
    notifyListeners();

    try {
      final response = await _repo.approveOrder(orderId, isApproved);

      _approveOrderState = UiState.success(response);
      getAllOrders();
      notifyListeners();
    } catch (e) {
      _approveOrderState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> addUserStock(
    String productId,
    String productName,
    String stock,
    String price,
    String category,
    String userId,
    String userName,
    String stockId,
  ) async {
    _addUserStockState = UiState.loading();
    notifyListeners();

    try {
      final response = await _repo.addUserStock(
        productId,
        productName,
        stock,
        price,
        category,
        userId,
        userName,
        stockId,
      );

      _addUserStockState = UiState.success(response);
      notifyListeners();
    } catch (e) {
      _addUserStockState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> deleteUserStock(String stockId) async {
    _deleteUserStockState = UiState.loading();
    notifyListeners();
    try {
      final data = await _repo.deleteStock(stockId);
      _deleteUserStockState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _deleteUserStockState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> approveUser(String userId, int isApproved) async {
    _approveUserState = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.approveUser(userId, isApproved);
      _approveUserState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _approveUserState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> getSpecificOrder(String orderId) async {
    _getSpecificOrderState = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.getSpecificOrder(orderId);
      _getSpecificOrderState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _getSpecificOrderState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> getSpecificUser(String userId) async {
    _getSpecificUserState = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.getSpecificUser(userId);
      _getSpecificUserState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _getSpecificUserState = UiState.error(e.toString());
      notifyListeners();
    }
  }


  Future<void> deleteSpecificOrder(String orderId) async {
    _deleteSpecificOrderStatus = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.deleteOrder(orderId);
      _deleteSpecificOrderStatus = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _deleteSpecificOrderStatus = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> deleteSpecificUser(String userid) async {
    _deleteSpecificUserState = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.deleteUser(userid);
      _deleteSpecificUserState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _deleteSpecificUserState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> getUserStock(String userId) async {
    _getUserStockState = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.getAllStock(userId);
      _getUserStockState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _getUserStockState = UiState.error(e.toString());
      notifyListeners();
    }
  }

}
