import 'package:flutter/material.dart';

import '../../components/inputs/text_form_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register"),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextFormInput(
                    labelText: "Job Title",
                    numLines: 1,
                    isDense: true,
                  ),
                  const TextFormInput(
                    labelText: "Job Title",
                    numLines: 1,
                    isDense: true,
                  ),
                  const TextFormInput(
                    labelText: "Phone Number",
                    numLines: 1,
                    isDense: true,
                  ),
                  const TextFormInput(
                    labelText: "Email",
                    numLines: 1,
                    isDense: true,
                  ),
                  InputDatePickerFormField(
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
