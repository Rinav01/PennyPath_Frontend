
import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class Category {
  final String id;
  final String name;
  final String icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      icon: json['icon'],
      color: Color(int.parse(json['color'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'color': color.value.toString(),
    };
  }
}

class ExpenseCategory {
  final String categoryId;
  final String name;
  final String icon;
  final Color color;

  ExpenseCategory({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) {
    return ExpenseCategory(
      categoryId: json['categoryId'],
      name: json['name'],
      icon: json['icon'],
      color: Color(int.parse(json['color'])),
    );
  }
}

class Expense {
  final String id;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;
  final String userId;

  Expense({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    required this.userId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['_id'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      category: ExpenseCategory.fromJson(json['category']),
      userId: json['userId'],
    );
  }
}
