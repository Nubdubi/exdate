import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  ProfileImage({Key? key, required this.initals}) : super(key: key);

  final String initals;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(54, 52, 59, 1),
            border: Border.all(
              width: 1,
              color: Color.fromRGBO(54, 52, 59, 1),
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 0.3,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          )
        ]));
  }
}
