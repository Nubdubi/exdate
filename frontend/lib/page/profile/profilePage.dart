import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //  header
          SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('company')),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('company')),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('company')),
                ],
              )
            ],
          ),
          Divider(),

          // body
          Column(
            children: [],
          ),
        ],
      ),
    );
  }
}
