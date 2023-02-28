// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import '../inputs/text_form_input.dart';

/**
 * The text fields and submit button on the last step of the booking process
 */
class BookingForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const BookingForm({super.key, required this.formKey});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return const Color.fromRGBO(92, 199, 208, 1);
      }
      return const Color.fromRGBO(27, 131, 139, 1);
    }

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TextFormInput(
            labelText: "How has this training been identified?",
            numLines: 3,
            isDense: false,
          ),
          TextFormInput(
            labelText: "How will you apply the learning in your role?",
            numLines: 3,
            isDense: false,
          ),
          TextFormInput(
            labelText: "How will you measure the success of this learning?",
            numLines: 3,
            isDense: false,
          ),
        ],
      ),
    );
  }
}
