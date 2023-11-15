import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  bool _initialized = false;
  UserCredential? _userCredential;
  GoogleSignInAccount? googleUser;

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default app $app");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    if (!_initialized) {
      await initializeDefault();
    }
    // Trigger the authentication flow
    googleUser = await GoogleSignIn().signIn();

    if (kDebugMode) {
      if (googleUser != null) {
        print(googleUser!.displayName);
      }
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    _userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {});
    return _userCredential!;
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    setState(() {
      googleUser = null;
    });
  }

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    if (googleUser != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Sign Out'),
            onPressed: () {
              logout();
              //Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Sign in With Google'),
            onPressed: () {
              signInWithGoogle();
              if (kDebugMode) {
                print(_userCredential?.user?.displayName);
              }

              //Navigator.pop(context);
            },
          ),
        ),
      );
    }
  }
}
