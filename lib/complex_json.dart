import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexJson extends StatefulWidget {
  const ComplexJson({super.key});

  @override
  State<ComplexJson> createState() => _ComplexJsonState();
}

class _ComplexJsonState extends State<ComplexJson> {
  List<complexJson> complexList = [];

  Future<List<complexJson>> complexGetApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        complexJson ComplexJson = complexJson(
            id: i['id'],
            name: i['name'],
            username: i['username'],
            email: i['email'],
            address: i['address']);
        complexList.add(ComplexJson);
      }
      return complexList;
    } else {
      return complexList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ComplexApi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
                future: complexGetApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      backgroundColor: Colors.deepPurpleAccent,
                    );
                  } else {
                    return ListView.builder(
                        itemCount: complexList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(snapshot.data![index].id
                                              .toString())),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Name: '),
                                          Text(snapshot.data![index].name
                                              .toString()),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('UserName: '),
                                          Text(snapshot.data![index].username
                                              .toString()),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Email: '),
                                          Text(snapshot.data![index].email
                                              .toString()),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Address:'),
                                          Column(
                                            children: [
                                              Text(snapshot.data![index]
                                                  .address['street']
                                                  .toString()),
                                              Text(snapshot
                                                  .data![index].address['city']
                                                  .toString()),
                                              Text(snapshot.data![index]
                                                  .address['zipcode']
                                                  .toString()),
                                              Text(snapshot.data![index]
                                                  .address['geo']['lat']
                                                  .toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

class complexJson {
  var id, name, username, email, address;

  complexJson(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address});
}
