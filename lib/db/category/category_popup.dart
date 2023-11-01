import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_manager_1/category.dart';
import 'package:money_manager_1/category_db.dart';
import 'package:money_manager_1/db/category/category_db1.dart';
import 'package:money_manager_1/home1.dart';

ValueNotifier<CategoryType> selectedindex = ValueNotifier(CategoryType.income);

class CategoryPopUp extends StatelessWidget {
  CategoryPopUp({super.key});
  final textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: TextFormField(
                controller: textcontroller,
                decoration: const InputDecoration(hintText: 'Purpose')),
          ),
          Row(children: const [
            RadioButton(title: 'Income', type: CategoryType.income),
            RadioButton(title: 'Expense', type: CategoryType.expense)
          ]),
          Padding(
            padding: const EdgeInsets.only(right: 285),
            child: ElevatedButton(
                onPressed: () {
                  final _name = textcontroller.text;
                  if (_name.isEmpty) {
                    return;
                  } else {
                    final _type = selectedindex.value;
                    final _category = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);

                    CategoryDb.instance.inserCategories(_category);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Submit')),
          )
        ],
      )),
    );
  }
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedindex,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      selectedindex.value = value;
                      selectedindex.notifyListeners();
                    }
                  });
            }),
        Text(title)
      ],
    );
  }
}
