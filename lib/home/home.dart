import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  HomeProvider provider = HomeProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("こんにちは"),
    );
  }



}

class HomeProvider extends RestorableInt {
  HomeProvider() : super(0);
}