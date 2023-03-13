import 'package:TheNomad/models/loginModel.dart';
import 'package:TheNomad/provider/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const String _title = "Nomad";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _saveForm();
    context.pushReplacement('/locationDetails');
    // if (_isValid) {
    //   LoginModel user = LoginModel(
    //       email: emailController.text, password: passwordController.text);
    //   loginProvider.signInUser(user).then((e) => {
    //         if (e == "Success")
    //           {context.pushReplacement('/search')}
    //         else
    //           {
    //             print("err $e"),
    //             showDialog<String>(
    //               context: context,
    //               builder: (BuildContext context) => AlertDialog(
    //                 title: Text(e.toString()),
    //                 actions: <Widget>[
    //                   TextButton(
    //                     onPressed: () => Navigator.pop(context, 'OK'),
    //                     child: const Text('OK'),
    //                   ),
    //                 ],
    //               ),
    //             )
    //           }
    //       });
    // }
  }

  void logout() {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.signOut();
  }

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
        title: const Text(_title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Welcome to NOMAD',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Log in to your account',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          // Check if this field is empty
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          // using regular expression
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please enter a valid email address";
                          }
                          // the email is valid
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Please enter your email address here',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 15, bottom: 20),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 8) {
                            return 'Password should be minimum 8 charcters';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Please enter your password here',
                        ),
                      ),
                    ),
                  ],
                )),
            TextButton(
              onPressed: () {
                // logout();
                // forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                onPressed: () {
                  loginUser();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    context.push('/signUp');
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
