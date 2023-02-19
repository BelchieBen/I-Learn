import 'package:flutter/material.dart';

class TextFormInput extends StatefulWidget {
  final String labelText;
  final int numLines;
  const TextFormInput({
    super.key,
    required this.labelText,
    required this.numLines,
  });

  @override
  State<TextFormInput> createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        TextFormField(
          validator: (String? value) {
            if (value == null || value.isEmpty) return "This field is required";
          },
          cursorColor: Color.fromRGBO(27, 131, 139, 1),
          maxLines: widget.numLines,
          minLines: widget.numLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(27, 131, 139, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
