import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_1/transactions_db.dart';

const TransactionDbName = 'Transaction_db_name';

abstract class TransactionDbFunctions {
  Future<List<TransactionModel>> gettransactions();
  Future<void> inserttransactions(TransactionModel value);
  Future<void> deletetransactions(String id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionvaluenotifier =
      ValueNotifier([]);

  @override
  Future<void> inserttransactions(TransactionModel value) async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TransactionDbName);
    await transaction_db.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<TransactionModel>> gettransactions() async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TransactionDbName);
    return transaction_db.values.toList();
  }

  @override
  Future<void> deletetransactions(String id) async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TransactionDbName);
    transaction_db.delete(id);
    refreshUI();
  }

  Future<void> refreshUI() async {
    final _list = await gettransactions();
    _list.sort((first, second) {
      return second.date.compareTo(first.date);
    });
    transactionvaluenotifier.value.clear();
    transactionvaluenotifier.value.addAll(_list);
    transactionvaluenotifier.notifyListeners();
  }
}
