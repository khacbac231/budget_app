import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:untitled/controllers/db_helper.dart';
import 'package:untitled/static.dart' as Static;

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "Some Expense";
  String type = "Income";
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 12),
        lastDate: DateTime(2100, 01));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Add Transaction",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.all(5.0),
                  child: Image.asset(
                    "assets/dong.png",
                    width: 37.0,
                    height: 37.0,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: "0", border: InputBorder.none),
                  style: TextStyle(fontSize: 24.0),
                  onChanged: (val) {
                    try {
                      amount = int.parse(val);
                    } catch (err) {}
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.circular(16.0)),
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.description,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Ghi chú", border: InputBorder.none),
                  style: TextStyle(fontSize: 24.0),
                  onChanged: (val) {
                    try {
                      note = val;
                    } catch (err) {}
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.circular(16.0)),
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.moving_sharp,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                avatar: Icon(
                  Icons.add_circle_outline,
                  color: type == "Income" ? Colors.white : Colors.black,
                ),
                label: Text(
                  "Income",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Income" ? Colors.white : Colors.black),
                ),
                selected: type == "Income" ? true : false,
                selectedColor: Static.PrimaryColor,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),
              SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                avatar: Icon(
                  Icons.remove_circle_outline,
                  color: type == "Expense" ? Colors.white : Colors.black,
                ),
                label: Text(
                  "Expense",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Expense" ? Colors.white : Colors.black),
                ),
                selected: type == "Expense" ? true : false,
                selectedColor: Static.PrimaryColor,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
              height: 50.0,
              child: TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Static.PrimaryColor,
                            borderRadius: BorderRadius.circular(16.0)),
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.date_range_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ))),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
                onPressed: () async {
                  if (amount != null && note.isNotEmpty) {
                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addData(amount!, selectedDate, note, type);
                    Navigator.of(context).pop();
                  } else {}
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                )),
          ),
        ],
      ),
    );
  }
}
