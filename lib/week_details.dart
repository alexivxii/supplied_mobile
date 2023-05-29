import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:async';

import 'package:supplied/dashboard.dart';

class WeekDetails extends StatefulWidget{

  List<dynamic> groceries_list_week;
  List<int> all_groceries;
  String week_name;
  String? document_id;
  int week_number;

  WeekDetails({required this.groceries_list_week, required this.week_name, required this.document_id, required this.week_number, required this.all_groceries});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<WeekDetails> {

  @override
  initState() {
    super.initState();
  }

  String dropdownValue = 'milk';
  List<int> last4weeks = [];

  

  void _showAlertDialog(BuildContext context) {

    print(dropdownValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context,SetStateSB)=>
          AlertDialog(
            title: Text('Select an item for your list'),
            content: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {

                print("reload");

                setState(() {
                  dropdownValue = newValue!;

                  // List<String> tempItems = ['milk', 'bread', 'eggs', 'cheese', 'yogurt', 'butter', 'orange juice', 'apple juice', 'soda', 'water', 'beer', 'wine', 'chips', 'cookies', 'crackers'];
                  // int indexOfProduct = tempItems.indexOf(dropdownValue);
                  // widget.groceries_list_week[indexOfProduct] = 1;

                });

                SetStateSB((){
                  dropdownValue = newValue!;
                });


              },
              items: <String>[
                'milk', 'bread', 'eggs', 'cheese', 'yogurt', 'butter', 'orange juice', 'apple juice', 'soda', 'water', 'beer', 'wine', 'chips', 'cookies', 'crackers' ,
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Perform some action with the selected option
                  print('Selected option: $dropdownValue');

                  setState(() {
                    List<String> tempItems = ['milk', 'bread', 'eggs', 'cheese', 'yogurt', 'butter', 'orange juice', 'apple juice', 'soda', 'water', 'beer', 'wine', 'chips', 'cookies', 'crackers'];
                    int indexOfProduct = tempItems.indexOf(dropdownValue);
                    widget.groceries_list_week[indexOfProduct] = 1;

                  });

                  late Map<String, int> groceries_map={
                    "milk": 0,
                    "bread": 0,
                    "eggs": 0,
                    "cheese": 0,
                    "yogurt": 0,
                    "butter": 0,
                    "orange juice": 0,
                    "apple juice": 0,
                    "soda": 0,
                    "water": 0,
                    "beer": 0,
                    "wine": 0,
                    "chips": 0,
                    "cookies": 0,
                    "crackers": 0
                  };

                  int index = 0;
                  for(String item in groceries_map.keys){
                    groceries_map[item] = int.parse(widget.groceries_list_week[index].toString());
                    index++;
                  }

                  List<String> itemsWithValueOne = groceries_map.entries
                      .where((entry) => entry.value == 1)
                      .map((entry) => entry.key)
                      .toList();

                  print(itemsWithValueOne.length);

                  FirebaseFirestore.instance.collection('weeks').doc(widget.document_id).update({'groceries_list': widget.groceries_list_week, 'item_count': itemsWithValueOne.length});

                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenTopPadding = MediaQuery.of(context).viewPadding.top;


    late Map<String, int> groceries_map={
      "milk": 0,
      "bread": 0,
      "eggs": 0,
      "cheese": 0,
      "yogurt": 0,
      "butter": 0,
      "orange juice": 0,
      "apple juice": 0,
      "soda": 0,
      "water": 0,
      "beer": 0,
      "wine": 0,
      "chips": 0,
      "cookies": 0,
      "crackers": 0
    };

    int index = 0;
    for(String item in groceries_map.keys){
      groceries_map[item] = int.parse(widget.groceries_list_week[index].toString());
      index++;
    }

    //print(groceries_map);

    List<String> itemsWithValueOne = groceries_map.entries
        .where((entry) => entry.value == 1)
        .map((entry) => entry.key)
        .toList();

    return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                //Todo: Header
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top:10, bottom: 10, left:20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                        offset: const Offset(0, 3), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: IconButton(
                          color: Colors.grey,
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed:(){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (context) => Dashboard()), (Route route) => false);
                            
                          },
                        ),
                      ),
                      Text(
                        widget.week_name,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                            onPressed: () {
                              if(widget.week_number > 4){
                                print("Pressed");

                              }

                            },
                            child: const Text(
                              "Prediction",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),

                //Todo: Title
                Container(
                  margin: const EdgeInsets.only(left: 20, top:20, right: 20, bottom: 0),
                  alignment: Alignment.center,
                  child: const Text(
                    "Your list",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //Todo: Cards
                Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: itemsWithValueOne.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top:10, bottom: 10, left:20, right: 20),
                            padding: const EdgeInsets.only(top:10, bottom: 10, left:20, right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                itemsWithValueOne[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    )
                ),
              ],
            ),

          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showAlertDialog(context);
          },
        tooltip: 'Add item',
        child: const Icon(Icons.add),
    ),
    );

  }

}

//Todo: Widgets

class _Header extends StatelessWidget{
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top:10,bottom: 10, left:20,right: 20),
      child: Row(
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 26,
              color: Color(0xffff682c),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  print("Pressed");
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => choosePackage(storeID: snapshot.data.docs[index].id),
                  //     ));
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}