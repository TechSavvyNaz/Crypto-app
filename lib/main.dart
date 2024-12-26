import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';  // Ensure this import works
import 'services/firestore_service.dart';
import 'screens/splash_screen.dart'; // Ensure this file exists and is correctly referenced
import 'auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBJVsLubuO2b6QdROe0ICF9KH7bwKlvJiY",  // Ensure these keys are for your Firebase project
        authDomain: "digital-a4b57.firebaseapp.com",
        projectId: "digital-a4b57",
        storageBucket: "digital-a4b57.firebasestorage.app",
        messagingSenderId: "488917786796",
        appId: "1:488917786796:web:17c50dac2b34f46fd4bf09",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
        StreamProvider<User?>.value(
          value: AuthService().authStateChanges, // This will listen to changes in the authentication state
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DigitalProducts Store',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: SplashScreen(),  // Ensure this screen is implemented correctly
      ),
    );
  }
}
