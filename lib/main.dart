import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main()=>runApp(MaterialApp(
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse;
  List listResponse;
  Map mapResponse;
  List listOfFacts;

    Future fetchData() async{
      http.Response response;
      response = await http
            .get('https://zenalpha.me/wp-json/wp/v2/users');
      //'https://www.thegrowingdeveloper.org/apiview?id=2'
      if(response.statusCode == 200) {
        setState(() {
          //mapResponse = json.decode(response.body);
          //listOfFacts = mapResponse['facts'];
          listOfFacts = json.decode(response.body);

        });
      }
    }
  @override
  void initState() {
      fetchData();
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Fetch Data From Api(Internet)'),
       backgroundColor: Colors.blue[900],
     ),
     body :
   listOfFacts==null?Container(): SingleChildScrollView(
     child: Column(
       children: <Widget>[
         Text(
           "List of users",
           //mapResponse['id'].toString(),
           style: TextStyle(fontSize: 30),
         ),
         ListView.builder(
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           itemBuilder: (context,index) {
           return Container(
             margin: EdgeInsets.all(10),
             child: Column(
               children: <Widget>[
               //Image.network(listOfFacts[index]['image_url']),
                 Text(
                   listOfFacts[index]['id'].toString(),
                   style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                 ),
                 Text(
                   listOfFacts[index]['name'].toString(),
                   style: TextStyle(fontSize: 18),
                 ),
                 ],
             ),
           );
         },
           itemCount: listOfFacts == null ? 0 : listOfFacts.length,
         )
       ],
     ),
   ),
   );
  }
}