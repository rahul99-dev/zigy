import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String stringResponse = '';
Map mapResponse = {};
Map dataResponse = {};
List listResponse = [];

class _MyHomePageState extends State<MyHomePage> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        //stringResponse = response.body;
        mapResponse = jsonDecode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('API DEMO'),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  GridTile(
                    child: Column(
                      children: [
                        Container(
                          child: Image.network(
                            listResponse[index]['avatar'],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(listResponse[index]['id'].toString()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listResponse[index]['first_name'].toString()),
                            SizedBox(
                              width: 5,
                            ),
                            Text(listResponse[index]['last_name'].toString()),
                          ],
                        ),
                        Text(listResponse[index]['email'].toString())
                      ],
                    ),
                  ),
                ],
              );
            },
            itemCount: listResponse.length,
          ),
        ));
  }
}
