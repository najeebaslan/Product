// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/product.dart';

Future<List<Product>> fetchPost() async {
  try {
    var headers = {
      'Authorization':
      /* ENTER HERE YOUR TOKEN IF YOU HAVE TOKEN */
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjhmZTc0MDVlZDg5Y2EwN2E5YzE2NzciLCJpc0FkbWluIjpmYWxzZSwiaXNCbG9jayI6ZmFsc2UsImxhbmd1YWdlIjoiRW5nbGlzaCIsImlhdCI6MTY1Mzg3NzMxMX0.Mj9jdYmBqvTk5pgHl5olyL-VMBv0TlMy72ZcKgr6e-8'
    };

    final response = await http.get(
      /* ENTER HERE YOUR LINK */
        Uri.parse('http://172.16.0.12:3000/area/location/getLocation'),
        headers: headers);

    if (response.statusCode == 200) {
      log(response.body.toString());
      List list = jsonDecode(response.body);

      return list.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Product');
    }
  } catch (e) {
    log('Error: $e');
    throw Exception('Failed to load Product');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Product>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: FutureBuilder<List<Product>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff97FFFF),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data![index].orderLines?[index].price}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].VarAreaCode}"),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}