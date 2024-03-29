import 'package:expense_app_flutter/model/transaction.dart';
import 'package:expense_app_flutter/widgets/chart.dart';
import 'package:expense_app_flutter/widgets/new_transaction.dart';
import 'package:expense_app_flutter/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
//    Transaction(
//        id: 't1', title: 'New shoes', amount: 69.99, date: DateTime.now()),
//    Transaction(id: 't2', title: 'Mobile', amount: 700, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTxt = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransaction.add(newTxt);
    });
  }

  void _deleteTransaction(int index){

    setState(() {
      _userTransaction.removeAt(index);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  bool _showChart=false;
  @override
  Widget build(BuildContext context) {

    final appBar=  AppBar(
      title: Text(
        "Personal Expenses",
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar:appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text("Show Chart"),
                Switch(value: _showChart, onChanged: (val){
                setState(() {
                  _showChart=val;
                });
              },)
            ],),

           _showChart? Container(
                height: (MediaQuery.of(context).size.height-appBar.preferredSize.height
                - MediaQuery.of(context).padding.top
                ) * 0.3,
                child: Chart(_recentTransactions))
           : Container(
                height: (MediaQuery.of(context).size.height-appBar.preferredSize.height
                    - MediaQuery.of(context).padding.top
                ) * 0.7,
                child: TransactionList(_userTransaction, _deleteTransaction))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
