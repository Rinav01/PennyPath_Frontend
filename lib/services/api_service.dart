
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pennypath/models/models.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:3000/api'; // Replace with your API base URL

  Future<Map<String, dynamic>> signup(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return _handleResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return _handleResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<Category> createCategory(String name, String icon, String color, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/categories/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': name, 'icon': icon, 'color': color}),
      );
      final data = _handleResponse(response);
      return Category.fromJson(data);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<List<Category>> getCategories(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/categories/list'),
        headers: {'Authorization': 'Bearer $token'},
      );
      final data = _handleResponse(response);
      return (data as List).map((json) => Category.fromJson(json)).toList();
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<Expense> createExpense(
      double amount, String date, String categoryId, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/expenses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'amount': amount,
          'date': date,
          'categoryId': categoryId,
        }),
      );
      final data = _handleResponse(response);
      return Expense.fromJson(data);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<List<Expense>> getExpenses(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/expenses'),
        headers: {'Authorization': 'Bearer $token'},
      );
      final data = _handleResponse(response);
      return (data as List).map((json) => Expense.fromJson(json)).toList();
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<Expense> updateExpense(String expenseId, double amount, String date,
      String categoryId, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/expenses/$expenseId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'amount': amount,
          'date': date,
          'categoryId': categoryId,
        }),
      );
      final data = _handleResponse(response);
      return Expense.fromJson(data);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<void> deleteExpense(String expenseId, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/expenses/$expenseId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      _handleResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return _handleResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> resetPassword(String token, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/reset-password/$token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'password': password}),
      );
      return _handleResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }
}
