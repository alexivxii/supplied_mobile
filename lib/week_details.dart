import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:async';

class WeekDetails extends StatefulWidget{

  List<dynamic> groceries_list_week;
  String week_name;
  WeekDetails({required this.groceries_list_week, required this.week_name});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<WeekDetails> {

  @override
  initState() {
    super.initState();
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
                            Navigator.pop(context);
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
                              print("Pressed");
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