import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_1/category_db.dart';
import 'package:money_manager_1/db/category/category_db1.dart';
import 'package:money_manager_1/db/category/transactions/transaction_db1.dart';
import 'package:money_manager_1/transactions_db.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refreshUI();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionvaluenotifier,
        builder:
            (BuildContext context, List<TransactionModel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final transaction = newlist[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        parsedate(transaction.date),
                        textAlign: TextAlign.center,
                      ),
                      radius: 25,
                      backgroundColor: transaction.type == CategoryType.income
                          ? Color.fromARGB(255, 40, 239, 47)
                          : Colors.red,
                    ),
                    title: Text(transaction.purpose),
                    subtitle: Text(transaction.amount.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        TransactionDb.instance
                            .deletetransactions(transaction.id!);
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 50,
                );
              },
              itemCount: newlist.length);
        });
  }

  String parsedate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _spliteddate = _date.split(' ');
    return '${_spliteddate.last}\n${_spliteddate.first}';
    //   return ('${date.day}\n${date.month} ');
  }
}
