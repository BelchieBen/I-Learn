import 'package:booking_app/src/pages/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/inputs/text_form_input.dart';
import '../../components/scaffold/app_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;

  // Form input values
  String? email;

  String? password;

  bool isLoading = false;

  // Method to be called when the form submit button is tapped
  void onSubmit() {
    // Dismiss the device keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    if (LoginPage.loginFormKey.currentState!.validate()) {
      setState(() => isLoading = true);
      LoginPage.loginFormKey.currentState!.save();
      if (_validateValues()) {
        // Call async function as this method cannot be asynchronous
        _authenticateUser();
      }
    }
  }

  // Async function to autneticate a user with Supabase and set the current user in the device preferences
  void _authenticateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      AuthResponse response = await supabase.auth
          .signInWithPassword(email: email, password: password!);
      if (response.user != null && response.session != null) {
        prefs.setString("currentUser", response.session.toString());
        setState(() => isLoading = false);
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AppScaffold()));
        }
      }
    } catch (error) {
      // If there is an error then display an error snackbar to inform the user
      setState(() => isLoading = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackbar(),
        );
      }
    }
  }

  // Helper function to validate the form input values before sending them to Supabase
  bool _validateValues() {
    if (email != null && password != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                minWidth: viewportConstraints.maxWidth,
              ),
              child: Theme(
                data: ThemeData(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: const Color.fromRGBO(5, 109, 120, 1),
                      ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(fontSize: 28),
                      ),
                      const Text(
                        "Signin to your I-Learn account",
                        style: TextStyle(
                          color: Color.fromRGBO(110, 120, 129, 1),
                        ),
                      ),
                      loginForm(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // The Login form with input fields and submit button.
  // I extracted this component to keep the main build method small and tidy.
  Form loginForm(BuildContext context) {
    return Form(
      key: LoginPage.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormInput(
                labelText: "Email",
                numLines: 1,
                isDense: true,
                obscureText: false,
                setValue: (value) => setState(() {
                  email = value;
                }),
              ),
              TextFormInput(
                labelText: "Password",
                numLines: 1,
                isDense: true,
                obscureText: true,
                setValue: (value) => setState(() {
                  password = value;
                }),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          onSubmit();
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 14,
                          width: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Color.fromRGBO(53, 69, 84, 1),
                          ))
                      : const Text("Login"),
                ),
              ),
            ],
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
            child: const Text("Signup"),
          )
        ],
      ),
    );
  }

  // The error snackbar to display when the user fails to login.
  // I display a generic message which is helpful to the majority of users
  SnackBar errorSnackbar() {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 60,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(226, 45, 56, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.error,
              color: Color.fromRGBO(255, 228, 230, 1),
            ),
            SizedBox(width: 6),
            Text("Invalid login credentials"),
          ],
        ),
      ),
    );
  }
}
