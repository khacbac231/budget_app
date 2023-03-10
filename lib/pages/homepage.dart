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
  void dispose() {
    Hive.close();
    super.dispose();
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: TextStyle(
                                        fontSize: 22.0, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    "0đ",
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: cardIncome("0"),
                                        ),
                                        Container(
                                          child: cardExpense("0"),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: EdgeInsets.all(6.0),
                          margin: EdgeInsets.symmetric(horizontal: 6.0),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(color: Static.PrimaryColor),
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Center(child: Text("No data!")))
                    ],
                  ),
                );
              }

              getTotalBalance(snapshot.data!);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
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
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Total Balance',
                                  style: TextStyle(
                                      fontSize: 22.0, color: Colors.white),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child:
                                            cardIncome(totalIncome.toString()),
                                      ),
                                      Container(
                                        child: cardExpense(
                                            totalExpense.toString()),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.all(6.0),
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(color: Static.PrimaryColor),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map sortedByValueMap = Map.fromEntries(snapshot
                              .data!.entries
                              .toList()
                            ..sort((e1, e2) =>
                                e1.value['date'].compareTo(e2.value['date'])));
                          Map compeleSortedData = {};
                          int keyTmp = 0;
                          Map key_data = {};
                          for (var k in sortedByValueMap.keys) {
                            compeleSortedData[keyTmp] = sortedByValueMap[k];
                            key_data[keyTmp] = k;
                            keyTmp++;
                          }
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    formatTime(compeleSortedData[index]['date']
                                        .toString()),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SizedBox(
                                    width: 85.0,
                                    child: Row(
                                      children: [
                                        Icon(
                                          compeleSortedData[index]['type'] ==
                                                  "Income"
                                              ? Icons.arrow_upward_outlined
                                              : Icons.arrow_downward_outlined,
                                          size: 15.0,
                                          color: compeleSortedData[index]
                                                      ['type'] ==
                                                  "Income"
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        Text(
                                          compeleSortedData[index]['type'],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: compeleSortedData[index]
                                                          ['type'] ==
                                                      "Income"
                                                  ? Colors.green
                                                  : Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90.0,
                                    child: Text(
                                      "${formatMoney(compeleSortedData[index]['amount'].toString())}đ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: compeleSortedData[index]
                                                      ['type'] ==
                                                  "Income"
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ),
                                  Text(
                                    compeleSortedData[index]['note'],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Delete"),
                                      IconButton(
                                        onPressed: () {
                                          dbHelper.deleteData(key_data[index]);
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          size: 30.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Update"),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit,
                                            size: 20.0,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Theme.of(context).primaryColor,
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: Text("Unexpected Error!"));
            }
          }),
    );
  }
}
