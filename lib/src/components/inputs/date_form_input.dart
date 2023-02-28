import 'package:flutter/material.dart';

class DateFormInput extends StatefulWidget {
  final String labelText;
  final bool isDense;
  const DateFormInput({
    super.key,
    required this.labelText,
    required this.isDense,
  });

  @override
  State<DateFormInput> createState() => _DateFormInputState();
}

class _DateFormInputState extends State<DateFormInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Text(widget.labelText),
          ),
          InputDatePickerFormField(
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
