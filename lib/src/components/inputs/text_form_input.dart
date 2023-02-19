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
            validator: (String? value) {
              if (value == null || value.isEmpty)
                return "This field is required";
            },
            cursorColor: const Color.fromRGBO(27, 131, 139, 1),
            maxLines: widget.numLines,
            minLines: widget.numLines,
            decoration: InputDecoration(
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
