import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';  // Make sure this import is correct

class SignupScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.black)),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.black)),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[800],
                foregroundColor: Colors.white,
              ),
              onPressed: () => _register(context),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register(BuildContext context) async {
    try {
      // Attempt to sign up the new user with Firebase
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Optional: Update the display name of the Firebase User
      await userCredential.user!.updateProfile(displayName: _nameController.text);
      await userCredential.user!.reload();

      // Navigate to the login screen after successful signup
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Handle the error if the email is already in use
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This email is already in use.')));
      } else {
        // Handle other FirebaseAuth errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign up: ${e.message}')));
      }
    } catch (e) {
      // Handle any other errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign up')));
    }
  }
}
