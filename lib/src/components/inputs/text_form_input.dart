import 'package:flutter/material.dart';

// Creating a custom type for calling setState in the parent widget
typedef StringCallback = void Function(String? val);

// Custom component to display a text field that complies with the Helix guidelines
class TextFormInput extends StatefulWidget {
  final String labelText;
  final int numLines;
  final bool isDense;
  final bool obscureText;
  final StringCallback setValue;
  const TextFormInput({
    super.key,
    required this.labelText,
    required this.numLines,
    required this.isDense,
    required this.obscureText,
    required this.setValue,
  });

  @override
  State<TextFormInput> createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
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
          TextFormField(
            // Change the helper text if the text field has hidden text (only used for passwords)
            validator: widget.obscureText
                ? (String? value) {
                    if (value == null || value.length < 6)
                      return "Password must be at least 6 characters";
                  }
                : (String? value) {
                    if (value == null || value.isEmpty)
                      return "This field is required";
                  },
            onSaved: (String? value) {
              // Call the parents setState method to access the value entered
              widget.setValue(value);
            },
            obscureText: widget.obscureText,
            cursorColor: const Color.fromRGBO(27, 131, 139, 1),
            maxLines: widget.numLines,
            minLines: widget.numLines,
            decoration: InputDecoration(
              isDense: widget.isDense,
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromRGBO(182, 187, 193, 1),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(27, 131, 139, 1),
                  ),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
