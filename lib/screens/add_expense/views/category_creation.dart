import 'package:pennypath/providers/category_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';


Future getCategoryCreation(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  List<String> myCategoriesIcons = ['entertainment', 'food', 'home', 'pet', 'shopping', 'tech', 'travel'];

  return showDialog(
    context: context,
    builder: (ctx) {
      bool isExpended = false;
      String iconSelected = '';
      Color categoryColor = colorScheme.surface;
      TextEditingController categoryNameController = TextEditingController();
      TextEditingController categoryIconController = TextEditingController();
      TextEditingController categoryColorController = TextEditingController();
      bool isLoading = false;

      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            backgroundColor: colorScheme.surface,
            title: Text('Create a Category', style: TextStyle(color: colorScheme.onSurface)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: categoryNameController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: colorScheme.surface,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colorScheme.outline)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: categoryIconController,
                      onTap: () {
                        setState(() {
                          isExpended = !isExpended;
                        });
                      },
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        suffixIcon: Icon(
                          CupertinoIcons.chevron_down,
                          size: 12,
                          color: colorScheme.onSurface,
                        ),
                        fillColor: colorScheme.surface,
                        hintText: 'Icon',
                        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
                        border: OutlineInputBorder(borderRadius: isExpended ? const BorderRadius.vertical(top: Radius.circular(12)) : BorderRadius.circular(12), borderSide: BorderSide(color: colorScheme.outline)),
                      ),
                    ),
                    isExpended
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(color: colorScheme.surface, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
                                  itemCount: myCategoriesIcons.length,
                                  itemBuilder: (context, int i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          iconSelected = myCategoriesIcons[i];
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 3, color: iconSelected == myCategoriesIcons[i] ? colorScheme.primary : colorScheme.outline), borderRadius: BorderRadius.circular(12), image: DecorationImage(image: AssetImage('assets/${myCategoriesIcons[i]}.png'))),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: categoryColorController,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx2) {
                              return AlertDialog(
                                backgroundColor: colorScheme.surface,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                      pickerColor: categoryColor,
                                      onColorChanged: (value) {
                                        setState(() {
                                          categoryColor = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(ctx2);
                                          },
                                          style: TextButton.styleFrom(backgroundColor: colorScheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                          child: Text(
                                            'Save Color',
                                            style: TextStyle(fontSize: 22, color: colorScheme.onPrimary),
                                          )),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: categoryColor,
                        hintText: 'Color',
                        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colorScheme.outline)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: kToolbarHeight,
                      child: isLoading == true
                          ? Center(
                              child: Lottie.asset('assets/Rupee Coin.json'),
                            )
                          : TextButton(
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                Provider.of<CategoryProvider>(context, listen: false)
                                    .createCategory(categoryNameController.text, iconSelected, categoryColor.value.toString())
                                    .then((_) {
                                  Navigator.pop(ctx);
                                });
                              },
                              style: TextButton.styleFrom(backgroundColor: colorScheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              child: Text(
                                'Save',
                                style: TextStyle(fontSize: 22, color: colorScheme.onPrimary),
                              )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}