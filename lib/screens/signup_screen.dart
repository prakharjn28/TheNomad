import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        Text(
                          "Create your account",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              makeInput(label: "First name"),
                              makeInput(label: "Last Name"),
                              makeInput(label: "Email"),
                              makeInput(label: "Password", obsureText: true),
                              makeInput(
                                  label: "Confirm Pasword", obsureText: true)
                            ],
                          ),
                        )),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        child: const Text(
                          'Create account',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        onPressed: () => context.goNamed("loginScreen"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(
                          onPressed: () => context.goNamed("loginScreen"),
                          child: const Text(
                            'Log in',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obsureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 25,
      )
    ],
  );
}
