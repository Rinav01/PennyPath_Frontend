
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:pennypath/models/models.dart';

class ApiService {
  final String _baseUrl = dotenv.env['API_BASE_URL']!;
  final http.Client _client = IOClient();

  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/api/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
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
      final response = await _client.post(
        Uri.parse('$_baseUrl/api/auth/login'),
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
      final response = await _client.post(
        Uri.parse('$_baseUrl/api/categories/create'),
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
      final response = await _client.get(
        Uri.parse('$_baseUrl/api/categories/list'),
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
      final response = await _client.post(
        Uri.parse('$_baseUrl/api/expenses'),
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
      final response = await _client.get(
        Uri.parse('$_baseUrl/api/expenses'),
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
      final response = await _client.put(
        Uri.parse('$_baseUrl/api/expenses/$expenseId'),
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
      final response = await _client.delete(
        Uri.parse('$_baseUrl/api/expenses/$expenseId'),
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
      final response = await _client.post(
        Uri.parse('$_baseUrl/api/auth/forgot-password'),
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
      final response = await _client.post(
        Uri.parse('$_baseUrl/api/auth/reset-password/$token'),
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
