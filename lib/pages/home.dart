import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas/pages/login.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String nama = "";
  String email = "";
  String password = "";

  late SharedPreferences pref;

  void getPref() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      nama = pref.getString("nama")!;
      email = pref.getString("email")!;
      password = pref.getString("password")!;
    });
  }

  void logOut() {
    pref.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  String alamatApi = "https://newsapi.org/v2/top-headlines?sources=";
  String source = "techcrunch";
  String apikey = "ec965c38b5cf4a26a7ec1bb0305778a9";

  List<dynamic> listNews = [];

  void getApi() {
    http
        .get(
      Uri.parse(alamatApi + source + "&apiKey=" + apikey),
    )
        .then((http.Response value) {
      if (value.statusCode == 200) {
        Map<String, dynamic> response = json.decode(value.body);
        listNews = response["articles"];
        print(listNews);
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  @override
  void initState() {
    getPref();
    getApi();
    super.initState();
  }

  //data Api

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "MyFilm",
          style: TextStyle(letterSpacing: 3),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: listNews.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                    ),
                    child: Text(
                      "Penulis : ${listNews[index]["author"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Image.network(
                    listNews[index]["urlToImage"],
                  ),
                  SizedBox(height: 5),
                  Text(
                    listNews[index]["description"],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Text("Photo"),
                ),
                accountName: Text(
                  nama,
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2,
                  ),
                ),
                accountEmail: Text(
                  email,
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 15,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.yellow,
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: Colors.yellow,
                ),
                title: Text(
                  "Data Pref",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: Colors.yellow,
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                onTap: logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
