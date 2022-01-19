import 'package:firebase_flutter/models/brew.dart';
import 'package:firebase_flutter/screens/home/brewTile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brew = Provider.of<List<Brew>>(context) ?? [];
    return ListView.builder(
        itemCount: brew.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brew[index]);
        });
  }
}
