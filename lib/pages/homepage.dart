import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled/controllers/db_helper.dart';
import 'package:untitled/pages/add.dart';
import 'package:untitled/static.dart' as Static;

import '../components/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  getTotalBalance(Map entireData) async {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if (value['type'] == "Income") {
        totalBalance += value['amount'] as int;
        totalIncome += value['amount'] as int;
      } else {
        totalBalance -= value['amount'] as int;
        totalExpense += value['amount'] as int;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => AddTransaction(),
          ))
              .whenComplete(() {
            setState(() {});
          });
        },
        backgroundColor: Static.PrimaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
      body: FutureBuilder<Map>(
          future: dbHelper.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Unexpected Error!"));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(child: Text("No data!"));
              }
              getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 32.0,
                              child: Image.asset(
                                "assets/face.png",
                                width: 64.0,
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              "Welcome NKB",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.settings,
                          size: 32.0,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: cardWidth,
                    margin: EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(colors: const [
                            Static.PrimaryColor,
                            Colors.blueAccent
                          ])),
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(
                            'Total Balance',
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "${formatMoney(totalBalance.toString())}đ",
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: cardIncome(totalIncome.toString()),
                                ),
                                Container(
                                  child: cardExpense(totalExpense.toString()),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: Text("Unexpected Error!"));
            }
          }),
    );
  }
}
