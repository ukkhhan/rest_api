import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/complex_json.dart';

class ComplexJsonStructure extends StatefulWidget {
  const ComplexJsonStructure({super.key});

  @override
  State<ComplexJsonStructure> createState() => _ComplexJsonStructureState();
}

class _ComplexJsonStructureState extends State<ComplexJsonStructure> {
  Future<ComplexJson> getComplexJson() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/eab9137b-11f6-41b4-877a-2a02d4b9efcb'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ComplexJson.fromJson(data);
    } else {
      return ComplexJson.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Icon(
            Icons.production_quantity_limits_sharp,
            size: 50,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ComplexJson>(
                future: getComplexJson(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(snapshot
                                      .data!.data![index].shop!.name!
                                      .toString()),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot
                                          .data!.data![index].shop!.description!
                                          .toString()),
                                      Text(snapshot
                                          .data!.data![index].shop!.shopemail!
                                          .toString()),
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.data![index].shop!.image!
                                        .toString()),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot
                                          .data!.data![index].images!.length,
                                      itemBuilder: (context, possition) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(40)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .data![index]
                                                        .images![possition]
                                                        .url
                                                        .toString()))),
                                          ),
                                        );
                                      }),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    "${snapshot.data!.data![index].saleTitle}: "),
                                                Text(
                                                  snapshot.data!.data![index]
                                                      .salePrice
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text('Add to favorite: '),
                                                Icon(snapshot.data!.data![index]
                                                            .inWishlist ==
                                                        true
                                                    ? Icons.favorite
                                                    : Icons.favorite_outlined),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text('Purchase Price: '),
                                                Text(
                                                  snapshot
                                                      .data!.data![index].price
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0),
                                                ),
                                              ],
                                            ),
                                            const Row(
                                              children: [
                                                Text('Add to Kart: '),
                                                Icon(Icons.add_shopping_cart),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.blue,
                        semanticsLabel: 'Please wait',
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
