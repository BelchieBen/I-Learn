import 'package:booking_app/src/components/inputs/custom_date_picker.dart';
import 'package:flutter/material.dart';

import '../../components/inputs/text_form_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? fullName;

  String? jobTitle;

  String? phoneNumber;

  String? email;

  String? dob;

  String? password;

  String? password2;

  void onSubmit() {
    if (RegisterPage.formKey.currentState!.validate()) {
      RegisterPage.formKey.currentState!.save();
      print(fullName);
      print(dob);
    }
  }

  void _validateValues() {}

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
                                  setValue: (value) => setState(() {
                                    fullName = value;
                                  }),
                                ),
                                TextFormInput(
                                  labelText: "Job Title",
                                  numLines: 1,
                                  isDense: true,
                                  setValue: (value) => setState(() {
                                    jobTitle = value;
                                  }),
                                ),
                                TextFormInput(
                                  labelText: "Phone Number",
                                  numLines: 1,
                                  isDense: true,
                                  setValue: (value) => setState(() {
                                    phoneNumber = value;
                                  }),
                                ),
                                TextFormInput(
                                  labelText: "Email",
                                  numLines: 1,
                                  isDense: true,
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
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      onSubmit();
                                    },
                                    child: const Text("Register"),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {},
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
