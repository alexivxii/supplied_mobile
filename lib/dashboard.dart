import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:async';
import 'package:supplied/week_details.dart';


class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Dashboard> {

  @override
  initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenTopPadding = MediaQuery.of(context).viewPadding.top;

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
                    const Text(
                      "Dashboard",
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
                            "Add list",
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
                  "Shopping Lists",
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
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        /*
                        Container(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Week 1",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "3 items",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        */
                        FutureBuilder(
                          future: FirebaseFirestore.instance.collection("weeks").get(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                            if(snapshot.hasData){
                              print(snapshot.data?.docs.length);
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index){
                                  QueryDocumentSnapshot<Object?>? document = snapshot.data?.docs[index];
                                  //print(document?.data()!["name"]);
                                  Map<String, dynamic> data = document?.data() as Map<String, dynamic>;
                                  String? doc_id = document?.id;
                                  String _name = data['name'];
                                  int _number = data['item_count'];
                                  List<dynamic> _groceries_list = data['groceries_list'];
                                  //print(name);
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WeekDetails(week_name: _name, groceries_list_week: _groceries_list, document_id: doc_id),
                                          ));
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(top:10, bottom: 10, left:20, right: 20),
                                      padding: const EdgeInsets.only(top:10, bottom: 10, left:20, right: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1.0,
                                            blurRadius: 3.0,
                                            offset: const Offset(0, 3), // changes the position of the shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _name,
                                            //snapshot.data?.docs[index].data()!["name"],
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${_number} items ",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else return Container();
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),

        ),
      )
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