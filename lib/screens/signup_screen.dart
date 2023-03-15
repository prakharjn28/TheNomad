import 'package:TheNomad/globalValidation.dart';
import 'package:TheNomad/provider/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _formKey.currentState!.validate();
    });
  }

  void signUp() {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // context.goNamed('loginScreen');
      loginProvider
          .signUpNewUser(_emailController.text, _passwordController.text)
          .then((e) => {
                if (e == "Success")
                  {context.pushReplacement('/search')}
                else
                  {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(e.toString()),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    )
                  }
              });
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                              makeInput(
                                  label: "First name",
                                  controller: _firstNameController),
                              makeInput(
                                  label: "Last Name",
                                  controller: _lastNameController),
                              makeInput(
                                  label: "Email", controller: _emailController),
                              makeInput(
                                  label: "Password",
                                  obsureText: true,
                                  controller: _passwordController),
                              makeInput(
                                  label: "Confirm Password",
                                  obsureText: true,
                                  controller: _confirmPasswordController),
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
                        onPressed: signUp,
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

  Widget makeInput(
      {required String label,
      bool obsureText = false,
      TextEditingController? controller}) {
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
        TextFormField(
          obscureText: obsureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            border: OutlineInputBorder(),
          ),
          controller: controller,
          validator: (value) {
            if (label == 'First name') {
              return isNameValid(value!)
                  ? 'Please enter your first name'
                  : null;
            } else if (label == 'Last Name') {
              return isLastNameValid(value!)
                  ? 'Please enter your last name'
                  : null;
            } else if (label == 'Email') {
              return isEmailValid(value!) ? null : 'Please enter a valid email';
            } else if (label == 'Password') {
              return isPasswordValid(value!)
                  ? null
                  : 'Password should be at least 6 characters';
            } else if (label == 'Confirm Password') {
              final password = _passwordController.text;
              return isVerifyPasswordValid(value!, password)
                  ? null
                  : 'Passwords do not match';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
