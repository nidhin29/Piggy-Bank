import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_manager_1/category_db.dart';
import 'package:money_manager_1/db/category/category_db1.dart';
import 'package:money_manager_1/db/category/category_popup.dart';
import 'package:money_manager_1/db/category/transactions/transaction_db1.dart';
import 'package:money_manager_1/home.dart';
import 'package:money_manager_1/home1.dart';
import 'package:money_manager_1/transactions_db.dart';

ValueNotifier<CategoryType> selectedvalue = ValueNotifier(CategoryType.income);
String? newselected;
TextEditingController purposecontroller = TextEditingController();
TextEditingController amountcontroller = TextEditingController();
CategoryModel? categorymo;

class TransactionPopUp extends StatefulWidget {
  TransactionPopUp({super.key});

  @override
  State<TransactionPopUp> createState() => _TransactionPopUpState();
}

class _TransactionPopUpState extends State<TransactionPopUp> {
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                controller: purposecontroller,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Purpose'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 260),
              child: TextButton.icon(
                  onPressed: () async {
                    final _selecteddatetemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now());
                    if (_selecteddatetemp == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedDate = _selecteddatetemp;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_selectedDate == null
                      ? 'Select Date'
                      : _selectedDate!.toString())),
            ),
            Row(
              children: const [
                Radiobutton(title: 'Income', type: CategoryType.income),
                Radiobutton(title: 'Expense', type: CategoryType.expense)
              ],
            ),
            ValueListenableBuilder(
                valueListenable: selectedvalue,
                builder:
                    (BuildContext context, CategoryType category, Widget? _) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 215),
                    child: DropdownButton(
                      hint: const Text('Select Category'),
                      value: newselected,
                      items: (category == CategoryType.income
                              ? CategoryDb().incomevaluenotifier.value
                              : CategoryDb().expensevaluenotifier.value)
                          .map((e) {
                        return DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name),
                          onTap: () {
                            categorymo = e;
                          },
                        );
                      }).toList(),
                      onChanged: (selectedindex) {
                        setState(() {
                          newselected = selectedindex;
                        });
                      },
                      onTap: () {},
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(right: 285),
              child: ElevatedButton(
                  onPressed: () {
                    addTransaction();

                    //    Navigator.of(context)
                    //        .pop(); //pushReplacement(MaterialPageRoute(builder: (ctx) {
                    //return const HomePage();
                    // }));
                  },
                  child: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final purpose = purposecontroller.text;
    final amount = amountcontroller.text;
    final parsevalue = double.tryParse(amount);
    if (parsevalue == null) {
      return;
    } else if (purpose.isEmpty) {
      return;
    } else if (amount.isEmpty) {
      return;
    } else if (newselected == null) {
      return;
    } else if (_selectedDate == null) {
      return;
    } else if (categorymo == null) {
      return;
    } else {
      final _model = TransactionModel(
          purpose: purpose,
          amount: parsevalue,
          date: _selectedDate!,
          type: selectedvalue.value,
          category: categorymo!);

      await TransactionDb.instance.inserttransactions(_model);

      Navigator.of(context).pop();//(MaterialPageRoute(builder: (ctx) {
      //  return const HomeScreen();
   //   }));
    }
  }
}

class Radiobutton extends StatelessWidget {
  final title;
  final type;
  const Radiobutton({required this.title, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedvalue,
        builder: (BuildContext context, CategoryType category, Widget? _) {
          return Row(
            children: [
              Radio<CategoryType>(
                  value: type,
                  groupValue: category,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      selectedvalue.value = value;
                      newselected = null;
                    }
                  }),
              Text(title)
            ],
          );
        });
  }
}
