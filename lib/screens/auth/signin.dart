import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/routes/route_names.dart';
import 'package:open_fashion/services/auth_service.dart';
import 'package:open_fashion/widgets/custome-text.dart';
import 'package:open_fashion/widgets/form_text_field.dart';
import 'package:open_fashion/widgets/header.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? errorFeedback = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Ionicons.chevron_back_circle,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.black,
        title: Header(
          title: 'Login to your account',
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50),
              //email text field
              CustomFormTextField(
                controller: _emailController,
                text: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              //password text field
              CustomFormTextField(
                controller: _passwordController,
                ispassword: true,
                text: 'password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50),

              if (errorFeedback != null)
                CustomeText(
                  text: errorFeedback!,
                  fontSize: 16,
                  color: Colors.red,
                ),
              //sign up button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      errorFeedback = null;
                    });
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    final user = await AuthService.signIn(email, password);

                    if (user != null) {
                      context.go(RouteNames.home);
                    }

                    // error feedback
                    if (user == null) {
                      setState(() {
                        errorFeedback = 'Invalid email or password';
                      });
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () async {
                  await AuthService.signOut();
                },
                child: Text('logout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
