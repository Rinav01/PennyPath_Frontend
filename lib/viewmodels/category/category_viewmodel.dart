
import 'package:flutter/material.dart';
import 'package:pennypath/models/models.dart';
import 'package:pennypath/services/api_service.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';

class CategoryViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AuthViewModel _authViewModel;

  CategoryViewModel(this._authViewModel);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    if (_authViewModel.token == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await _apiService.getCategories(_authViewModel.token!);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCategory(String name, String icon, String color) async {
    if (_authViewModel.token == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newCategory = await _apiService.createCategory(name, icon, color, _authViewModel.token!);
      _categories.insert(0, newCategory);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
