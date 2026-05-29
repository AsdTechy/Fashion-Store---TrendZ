import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import '../screens/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        String message;

        switch (e.code) {
          case 'user-not-found':
            message = "No account found";
            break;

          case 'wrong-password':
            message = "Incorrect password";
            break;

          case 'invalid-email':
            message = "Invalid email";
            break;

          case 'invalid-credential':
            message = "Email or password is incorrect";
            break;

          default:
            message = "Login failed";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F7EF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),

                Text(
                  "TrendZ",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller:
                            emailController,
                        keyboardType:
                            TextInputType
                                .emailAddress,
                        decoration:
                            inputDecoration(
                          "Email",
                          Icons.email,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Enter email";
                          }

                          if (!RegExp(
                            r'^[^@]+@[^@]+\.[^@]+',
                          ).hasMatch(value)) {
                            return "Enter valid email";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(
                          height: 20),

                      TextFormField(
                        controller:
                            passwordController,
                        obscureText: true,
                        decoration:
                            inputDecoration(
                          "Password",
                          Icons.lock,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Enter password";
                          }

                          if (value.length <
                              6) {
                            return "Minimum 6 characters";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(
                          height: 20),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 50,
                        child:
                            ElevatedButton(
                          onPressed:
                              isLoading
                                  ? null
                                  : loginUser,
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.white,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      30),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors
                                      .green,
                                )
                              : const Text(
                                  "Login",
                                  style:
                                      TextStyle(
                                    color: Colors
                                        .green,
                                    fontSize:
                                        16,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(
                          height: 15),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const Register(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account? SIGN UP",
                          style: TextStyle(
                            color:
                                Colors.white,
                            fontSize: 12,
                            decoration:
                                TextDecoration
                                    .underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}