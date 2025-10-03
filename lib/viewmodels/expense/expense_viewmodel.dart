
import 'package:flutter/material.dart';
import 'package:pennypath/models/models.dart';
import 'package:pennypath/services/api_service.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';

import 'package:pennypath/viewmodels/loading_viewmodel.dart';

class ExpenseViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AuthViewModel _authViewModel;
  final LoadingViewModel _loadingViewModel;

  ExpenseViewModel(this._authViewModel, this._loadingViewModel);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  Future<void> fetchExpenses() async {
    if (_authViewModel.token == null) return;

    _loadingViewModel.startLoading();
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _expenses = await _apiService.getExpenses(_authViewModel.token!);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _loadingViewModel.stopLoading();
    }
    notifyListeners();
  }

  Future<void> createExpense(double amount, String date, String categoryId) async {
    if (_authViewModel.token == null) return;

    _loadingViewModel.startLoading();
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newExpense = await _apiService.createExpense(amount, date, categoryId, _authViewModel.token!);
      _expenses.insert(0, newExpense);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _loadingViewModel.stopLoading();
    }
    notifyListeners();
  }

  Future<void> updateExpense(String expenseId, double amount, String date, String categoryId) async {
    if (_authViewModel.token == null) return;

    _loadingViewModel.startLoading();
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedExpense = await _apiService.updateExpense(expenseId, amount, date, categoryId, _authViewModel.token!);
      final index = _expenses.indexWhere((exp) => exp.id == expenseId);
      if (index != -1) {
        _expenses[index] = updatedExpense;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _loadingViewModel.stopLoading();
    }
    notifyListeners();
  }

  Future<void> deleteExpense(String expenseId) async {
    if (_authViewModel.token == null) return;

    _loadingViewModel.startLoading();
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.deleteExpense(expenseId, _authViewModel.token!);
      _expenses.removeWhere((exp) => exp.id == expenseId);
    } catch (e) {
      _errorMessage = e.toString();
    }
    finally {
      _isLoading = false;
      _loadingViewModel.stopLoading();
    }
    notifyListeners();
  }
}
