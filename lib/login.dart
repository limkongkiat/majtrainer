import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 97, 51),
        appBar: AppBar(
          title: const Text('Mahjong Trainer',
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 13, 97, 51),
        ),
        body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late User user;

  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }

  void clickGoogle() {
    signInWithGoogle().then((user) => {
          this.user = user,
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(user)))
        });
  }

  void clickAnon() {
    signInAnon().then((user) => {
          this.user = user,
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(user)))
        });
  }

  Widget googleLoginButton() {
    return Container(
        width: 300,
        height: 75,
        child: ElevatedButton(
          onPressed: this.clickGoogle,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text('Sign in with Google',
              style: TextStyle(fontSize: 25, color: Colors.white)),
        ));
  }

  Widget anonLoginButton() {
    return Container(
        width: 300,
        height: 75,
        child: ElevatedButton(
          onPressed: this.clickAnon,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text('Sign in Anonymously',
              style: TextStyle(fontSize: 25, color: Colors.white)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                googleLoginButton(),
                const SizedBox(height: 30),
                anonLoginButton()
              ])),
    );
  }
}
