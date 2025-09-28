import 'dart:math';
import 'package:pennypath/viewmodels/category/category_viewmodel.dart';
import 'package:pennypath/viewmodels/expense/expense_viewmodel.dart';
import 'package:pennypath/views/screens/add_expense/add_expense.dart';
import 'package:pennypath/views/screens/home/main_screen.dart';
import 'package:pennypath/views/screens/stats/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseViewModel>(context, listen: false).fetchExpenses();
      Provider.of<CategoryViewModel>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<ExpenseViewModel>(
      builder: (context, expenseProvider, child) {
        if (expenseProvider.isLoading) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: Center(
              child: Lottie.asset('assets/Rupee Coin.json'),
            ),
          );
        }
        return Scaffold(
          backgroundColor: colorScheme.surface,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: BottomNavigationBar(
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  backgroundColor: colorScheme.surface,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 0,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home,
                            color: index == 0 ? colorScheme.primary : colorScheme.onSurface),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.graph_square_fill,
                            color: index == 1 ? colorScheme.primary : colorScheme.onSurface),
                        label: 'Stats'),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const AddExpense(),
                ),
              );
            },
            shape: const CircleBorder(),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.secondary,
                    colorScheme.tertiary,
                  ],
                  transform: const GradientRotation(pi / 4),
                ),
              ),
              child: Icon(CupertinoIcons.add, color: colorScheme.onPrimary),
            ),
          ),
          body: index == 0 ? const MainScreen() : const StatScreen(),
        );
      },
    );
  }
}