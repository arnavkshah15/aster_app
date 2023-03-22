import 'dart:convert';

import 'package:aster_app/item_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Itemmodel> plist = [];
Future<List<Itemmodel>> getPostapi() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    plist.clear();
    for (Map i in data) {
      plist.add(Itemmodel.fromJson(i));
    }
    return plist;
  } else {
    return plist;
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(Icons.menu),
      ),
      backgroundColor: Colors.blue,
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getPostapi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: SizedBox(
                        width: 48.0,
                        height: 48.0,
                        child: CircularProgressIndicator()));
              } else {
                return ListView.builder(
                    itemCount: plist.length,
                    itemBuilder: (context, index) {
                      final color = index.isOdd ? Colors.orange : Colors.green;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: color,
                              border: Border.all(style: BorderStyle.none),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'UserId : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      plist[index].userId.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'ID : ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      plist[index].id.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                Text(
                                  'Title :',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  plist[index].title.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                Text(
                                  'Body :',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  plist[index].body.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return Container();
            },
          ),
        )
      ]),
    );
  }
}
