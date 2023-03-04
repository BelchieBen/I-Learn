import 'package:booking_app/src/components/inputs/custom_date_picker.dart';
import 'package:booking_app/src/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/inputs/text_form_input.dart';
import '../../components/scaffold/app_scaffold.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final supabase = Supabase.instance.client;

  String? fullName;

  String? jobTitle;

  String? phoneNumber;

  String? email;

  String? dob;

  String? password;

  String? password2;

  User? user;

  bool isLoading = false;

  void onSubmit() {
    if (RegisterPage.formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      RegisterPage.formKey.currentState!.save();
      if (_validateValues()) {
        _registerUser();
      }
    }
  }

  void _registerUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthResponse response =
        await supabase.auth.signUp(email: email, password: password!);

    if (response.user != null && response.session != null) {
      final List<Map<String, dynamic>> profile =
          await supabase.from("user_profile").insert({
        "user_id": response.user?.id,
        "profile_img": "default.png",
        "job_title": jobTitle,
        "dob": dob,
        "full_name": fullName
      }).select();

      if (profile.isNotEmpty) {
        setState(() {
          user = response.user;
        });

        prefs.setString("currentUser", response.session.toString());
        setState(() => isLoading = false);
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AppScaffold()));
        }
      }
    }
  }

  bool _validateValues() {
    if (fullName != null &&
        jobTitle != null &&
        phoneNumber != null &&
        email != null &&
        dob != null &&
        password != null &&
        password2 != null &&
        password == password2) {
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
                        "Register",
                        style: TextStyle(fontSize: 28),
                      ),
                      const Text(
                        "Signup to I-Learn and start learning",
                        style: TextStyle(
                          color: Color.fromRGBO(110, 120, 129, 1),
                        ),
                      ),
                      Form(
                        key: RegisterPage.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormInput(
                                  labelText: "Full Name",
                                  numLines: 1,
                                  isDense: true,
                                  obscureText: false,
                                  setValue: (value) => setState(() {
                                    fullName = value;
                                  }),
                                ),
                                TextFormInput(
                                  labelText: "Job Title",
                                  numLines: 1,
                                  isDense: true,
                                  obscureText: false,
                                  setValue: (value) => setState(() {
                                    jobTitle = value;
                                  }),
                                ),
                                TextFormInput(
                                  labelText: "Phone Number",
                                  numLines: 1,
                                  isDense: true,
                                  obscureText: false,
                                  setValue: (value) => setState(() {
                                    phoneNumber = value;
                                  }),
                                ),
                                TextFormInput(
                                  labelText: "Email",
                                  numLines: 1,
                                  isDense: true,
                                  obscureText: false,
                                  setValue: (value) => setState(() {
                                    email = value;
                                  }),
                                ),
                                CustomDateFormInput(
                                  labelText: "Date of Birth",
                                  isDense: true,
                                  setValue: (value) => setState(() {
                                    dob = value;
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
                                TextFormInput(
                                  labelText: "Confirm Password",
                                  numLines: 1,
                                  isDense: true,
                                  obscureText: true,
                                  setValue: (value) => setState(() {
                                    password2 = value;
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
                                              color:
                                                  Color.fromRGBO(53, 69, 84, 1),
                                            ))
                                        : const Text("Register"),
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
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text("Login"),
                            )
                          ],
                        ),
                      ),
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
}
