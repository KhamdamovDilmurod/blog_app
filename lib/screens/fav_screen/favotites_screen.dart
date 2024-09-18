import 'package:flutter/material.dart';

class FavotitesScreen extends StatefulWidget {
  const FavotitesScreen({Key? key}) : super(key: key);

  @override
  _FavotitesScreenState createState() => _FavotitesScreenState();
}

class _FavotitesScreenState extends State<FavotitesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Faavorite Screen"),
      ),
    );
  }
}
