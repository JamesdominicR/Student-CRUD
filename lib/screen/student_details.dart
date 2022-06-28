import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../assets/data_model.dart';

class StudentScreenDetails extends StatefulWidget {
  String name, place, phone, image;
  StudentScreenDetails(
      {Key? key,
      required this.name,
      required this.place,
      required this.phone,
      required this.image})
      : super(key: key);

  @override
  State<StudentScreenDetails> createState() => _StudentScreenDetailsState();
}

class _StudentScreenDetailsState extends State<StudentScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: FileImage(File(widget.image)),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.place,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.phone,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
