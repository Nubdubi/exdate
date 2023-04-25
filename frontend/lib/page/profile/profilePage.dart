import 'package:flutter/material.dart';
import 'package:frontend/page/auth/loginpage.dart';
import 'package:frontend/page/mainpage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    clientId:
        '317921682520-osl28bu3k92j0st1hjm9ehvc8m9n29jl.apps.googleusercontent.com',
    scopes: scopes,
  );
  Future<void> _handleSignOut() => _googleSignIn.disconnect();
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
                child: InkWell(
                  onTap: () {
                    setState(() {
                                            
                      _handleSignOut();
                      Navigator.of(context).
                    });
                 
                  },
                  child: Text('h'),
                ),
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
