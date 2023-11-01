import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_1/category_db.dart';

const Category_Db_Name = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> inserCategories(CategoryModel value);
  Future<void> deleteCategories(String id);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomevaluenotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expensevaluenotifier = ValueNotifier([]);
  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(Category_Db_Name);
    return _categoryDb.values.toList();
  }

  @override
  Future<void> inserCategories(CategoryModel value) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(Category_Db_Name);
    await _categoryDb.put(value.id,value);
    refreshUI();
  }

  Future<void> refreshUI() async {
    final _category = await getCategories();
    incomevaluenotifier.value.clear();
    expensevaluenotifier.value.clear();
    await Future.forEach(_category, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomevaluenotifier.value.add(category);
      } else {
        expensevaluenotifier.value.add(category);
      }
    });
    incomevaluenotifier.notifyListeners();
    expensevaluenotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategories(String id) async {
    final _categoryb = await Hive.openBox<CategoryModel>(Category_Db_Name);
    await _categoryb.delete(id);
    refreshUI();
  }
}
