import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  String email = "";
  String phone = "";
  String avatar = "";

  Future<void> getData() async {
    Response response = await get(Uri.parse("https://randomuser.me/api/"));
    Map data = jsonDecode(response.body);
    name = data["results"][0]["name"]["title"] +
        " " +
        data["results"][0]["name"]["first"] +
        " " +
        data["results"][0]["name"]["last"];
    email = data["results"][0]["email"];
    phone = data["results"][0]["phone"];
    avatar = data["results"][0]["picture"]["thumbnail"];
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe0e0e0),
      appBar: AppBar(
        title: const Text(
          'Random Data Generator',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFe0e0e0),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xFFe0e0e0),
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                blurRadius: 60,
                spreadRadius: 0.15,
                color: Color(0xFFbebebe),
                offset: Offset(20, 20),
              ),
              BoxShadow(
                blurRadius: 60,
                spreadRadius: 0.15,
                color: Color(0xFFffffff),
                offset: Offset(-20, -20),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blueAccent,
                    backgroundImage: NetworkImage(avatar),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  email,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFe0e0e0),
        foregroundColor: Colors.black,
        onPressed: () {
          setState(() {
            getData();
          });
        },
        child: const Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}
