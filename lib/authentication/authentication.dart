import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:machinetest/authentication/googlesignin.dart';
import 'package:machinetest/authentication/login.dart';
import 'package:machinetest/authentication/otp.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100.0),
            Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCk1x9UcNkwOCnD_5Wlx8sAnPksSMIH3zfGl3e4mZ00A&s"),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue, // Set button color here
                    ),
                    onPressed: () {
                       Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );

                    },
                    child: Expanded(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://blog.hubspot.com/hubfs/image8-2.jpg'),
                          radius: 12,
                        ),
                        title: Center(child: Text('Google')),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 74, 163, 77), // Set button color here
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Expanded(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn4.iconfinder.com/data/icons/social-media-2097/94/phone-512.png'),
                          radius: 12,
                        ),
                        title: Center(child: Text('Phone')),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
