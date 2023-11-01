import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_manager_1/category_db.dart';
import 'package:money_manager_1/db/category/category_db1.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expensevaluenotifier,
        builder:
            (BuildContext context, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final _category = newList[index];
                return Card(
                  child: ListTile(
                    leading: Text(_category.name),
                    trailing: IconButton(
                      onPressed: () {
                        CategoryDb.instance.deleteCategories(_category.id);
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
              itemCount: newList.length);
        });
  }
}
