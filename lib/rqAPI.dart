import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CallAPI extends StatefulWidget {
  const CallAPI({Key? key}) : super(key: key);

  @override
  _CallAPI createState() => _CallAPI();
}

class _CallAPI extends State<CallAPI> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    print(data);
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff5ad42),
        centerTitle: true,
        title: Text('Quản Lý Album'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,),
                              child: ListTile(
                                leading: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Image.network(
                                    (snapshot.data![index].url.toString()),
                                  ),
                                ),
                                subtitle:
                                Text('title: ' + snapshot.data![index].title.toString()),
                                title: Text('id:' +
                                    snapshot.data![index].id.toString()),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}

class Photos {
  String title, url;

  int id;

  Photos({required this.title, required this.url, required this.id});
}
