import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pennypath/viewmodels/category/category_viewmodel.dart';
import 'package:pennypath/viewmodels/expense/expense_viewmodel.dart';
import 'package:pennypath/views/screens/add_expense/category_creation.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/models/models.dart' as models;

import 'package:lottie/lottie.dart';

class AddExpense extends StatefulWidget {
  final models.Expense? expense;
  const AddExpense({super.key, this.expense});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  
  models.Category? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _expenseController.text = widget.expense!.amount.toString();
      _selectedCategory = models.Category(
        id: widget.expense!.category.categoryId,
        name: widget.expense!.category.name,
        icon: widget.expense!.category.icon,
        color: widget.expense!.category.color,
      );
      _categoryController.text = _selectedCategory!.name;
      _selectedDate = widget.expense!.date;
      _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
    } else {
      _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
        ),
        body: Consumer<CategoryViewModel>(
          
          builder: (context, categoryProvider, child) {
            if (categoryProvider.isLoading) {
              return Center(
                child: Lottie.asset('assets/Rupee Coin.json'),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.expense == null ? "Add Expenses" : "Edit Expense",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: colorScheme.onSurface),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: _expenseController,
                        keyboardType: TextInputType.number,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: colorScheme.surface,
                          prefixIcon: Icon(
                            FontAwesomeIcons.dollarSign,
                            size: 16,
                            color: colorScheme.onSurface,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: colorScheme.outline)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      controller: _categoryController,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      onTap: () {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _selectedCategory == null ? colorScheme.surface : _selectedCategory!.color,
                        prefixIcon: _selectedCategory == null
                            ? Icon(
                                FontAwesomeIcons.list,
                                size: 16,
                                color: colorScheme.onSurface,
                              )
                            : Image.asset(
                                'assets/${_selectedCategory!.icon}.png',
                                scale: 2,
                              ),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              var newCategory = await getCategoryCreation(context);
                              if (newCategory != null) {
                                setState(() {
                                  categoryProvider.createCategory(newCategory.name, newCategory.icon, newCategory.color.value.toString());
                                });
                              }
                            },
                            icon: Icon(
                              FontAwesomeIcons.plus,
                              size: 16,
                              color: colorScheme.onSurface,
                            )),
                        hintText: 'Category',
                        border: OutlineInputBorder(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), borderSide: BorderSide(color: colorScheme.outline)),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: categoryProvider.categories.length,
                            itemBuilder: (context, int i) {
                              final category = categoryProvider.categories[i];
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      _selectedCategory = category;
                                      _categoryController.text = category.name;
                                    });
                                  },
                                  leading: Image.asset(
                                    'assets/${category.icon}.png',
                                    scale: 2,
                                  ),
                                  title: Text(category.name, style: TextStyle(color: colorScheme.onPrimary)),
                                  tileColor: category.color,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _dateController,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context, 
                            initialDate: _selectedDate, 
                            firstDate: DateTime(2000), 
                            lastDate: DateTime.now().add(const Duration(days: 365))
                          );

                        if (newDate != null) {
                          setState(() {
                            _dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                            _selectedDate = newDate;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colorScheme.surface,
                        prefixIcon: Icon(
                          FontAwesomeIcons.clock,
                          size: 16,
                          color: colorScheme.onSurface,
                        ),
                        hintText: 'Date',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colorScheme.outline)),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Consumer<ExpenseViewModel>(
                      builder: (context, expenseViewModel, child) {
                        return SizedBox(
                          width: double.infinity,
                          height: kToolbarHeight,
                          child: expenseViewModel.isLoading
                              ? Center(child: Lottie.asset('assets/Rupee Coin.json'))
                              : TextButton(
                                  onPressed: () {
                                    if (_selectedCategory != null) {
                                      final amount = double.parse(_expenseController.text);
                                      final date = DateFormat('yyyy-MM-dd').format(_selectedDate);
                                      if (widget.expense == null) {
                                        expenseViewModel.createExpense(amount, date, _selectedCategory!.id).then((_) {
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        expenseViewModel.updateExpense(widget.expense!.id, amount, date, _selectedCategory!.id).then((_) {
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        });
                                      }
                                    }
                                  },
                                  style: TextButton.styleFrom(backgroundColor: colorScheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(fontSize: 22, color: colorScheme.onPrimary),
                                  )),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}