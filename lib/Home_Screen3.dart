import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/user_model.dart';

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({super.key});

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  List<UserModel> usersList = [];

  Future<List<UserModel>> getUsersApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        usersList.add(UserModel.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Users List',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUsersApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      strokeAlign: 12,
                    );
                  } else {
                    return ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: usersRow(
                                        title: 'Name',
                                        value: snapshot.data![index].name
                                            .toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: usersRow(
                                        title: 'User Name',
                                        value: snapshot.data![index].username
                                            .toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: usersRow(
                                        title: 'Email',
                                        value: snapshot.data![index].email
                                            .toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: usersRow(
                                        title: 'Address',
                                        value: snapshot
                                                .data![index].address!.street
                                                .toString() +
                                            '\n' +
                                            snapshot.data![index].address!.suite
                                                .toString() +
                                            '\n' +
                                            snapshot.data![index].address!.city
                                                .toString() +
                                            '\n' +
                                            snapshot
                                                .data![index].address!.zipcode
                                                .toString() +
                                            '\n' +
                                            snapshot
                                                .data![index].address!.geo!.lng
                                                .toString() +
                                            '\n' +
                                            snapshot
                                                .data![index].address!.geo!.lat
                                                .toString()),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class usersRow extends StatelessWidget {
  String title, value;

  usersRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        Text(value),
      ],
    );
  }
}
