
import 'package:flutter/material.dart';
import 'package:pennypath/models/models.dart';
import 'package:pennypath/services/api_service.dart';

import 'auth_provider.dart';

class ExpenseProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AuthProvider _authProvider;

  ExpenseProvider(this._authProvider);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  Future<void> fetchExpenses() async {
    if (_authProvider.token == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _expenses = await _apiService.getExpenses(_authProvider.token!);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createExpense(double amount, String date, String categoryId) async {
    if (_authProvider.token == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newExpense = await _apiService.createExpense(amount, date, categoryId, _authProvider.token!);
      _expenses.insert(0, newExpense);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateExpense(String expenseId, double amount, String date, String categoryId) async {
    if (_authProvider.token == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedExpense = await _apiService.updateExpense(expenseId, amount, date, categoryId, _authProvider.token!);
      final index = _expenses.indexWhere((exp) => exp.id == expenseId);
      if (index != -1) {
        _expenses[index] = updatedExpense;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    if (_authProvider.token == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.deleteExpense(expenseId, _authProvider.token!);
      _expenses.removeWhere((exp) => exp.id == expenseId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
