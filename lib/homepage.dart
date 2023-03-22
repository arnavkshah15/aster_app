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
      appBar: AppBar(),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getPostapi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                Text("Loading");
              } else {
                return ListView.builder(
                    itemCount: plist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Id: ' + plist[index].id.toString()),
                              Text('UserId: ' + plist[index].userId.toString()),
                              Text('Title: ' + plist[index].title.toString()),
                              Text('Body: ' + plist[index].body.toString()),
                            ],
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
