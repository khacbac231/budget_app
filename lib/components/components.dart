import 'package:flutter/material.dart';

Widget cardIncome(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(6.0),
        child: Icon(
          Icons.arrow_downward,
          color: Colors.green,
        ),
      ),
      SizedBox(
        width: 12.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Income",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          Text(
            "${formatMoney(value)}đ",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          )
        ],
      )
    ],
  );
}

Widget cardExpense(String value) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Expense",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          Text(
            "${formatMoney(value)}đ",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
      SizedBox(
        width: 12.0,
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(6.0),
        child: Icon(
          Icons.arrow_upward,
          color: Colors.red,
        ),
      ),
    ],
  );
}

String formatMoney(String value) {
  String output = "";
  int length = value.length;
  int index = 0;
  while (length > 0) {
    if (index == 3) {
      output += ".";
      output += value[length - 1];
      index = 0;
    } else {
      output += value[length - 1];
    }
    index++;
    length--;
  }
  return String.fromCharCodes(output.runes.toList().reversed);
}

String formatTime(String value) {
  List<String> listStr = value.split(' ');
  List<String> subListStr = listStr[0].split('-');
  String output = "${subListStr[2]}/${subListStr[1]}/${subListStr[0]}";
  return output;
}
