import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_manager_1/category.dart';
import 'package:money_manager_1/category_db.dart';
import 'package:money_manager_1/db/category/category_db1.dart';
import 'package:money_manager_1/db/category/category_popup.dart';
import 'package:money_manager_1/db/category/transaction_popup.dart';
import 'package:money_manager_1/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final _pages = const [HomePage(), CategoryScreen()];
  int _currentnewvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 229, 229),
      appBar: AppBar(
        title: const SizedBox(
          child: Text(
            'MONEY MANAGER APP',
            textAlign: TextAlign.center,
          ),
          width: double.infinity,
        ),
      ),
      body: _pages[_currentnewvalue],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentnewvalue,
          onTap: (newIndex) {
            setState(() {
              _currentnewvalue = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.money), label: 'Transaction'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentnewvalue == 0) {
            print('add transaction');
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx1) {
              return TransactionPopUp();
            }));
          } else {
            print('add category');
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return CategoryPopUp();
            }));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
