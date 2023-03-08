import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Creating a custom type for calling setState in the parent widget
typedef StringCallback = void Function(String? val);

// This component is a custom date selector as the Material selector's behaviour did not match Helix's guidelines
class CustomDateFormInput extends StatefulWidget {
  final String labelText;
  final bool isDense;
  final StringCallback setValue;
  const CustomDateFormInput({
    super.key,
    required this.labelText,
    required this.isDense,
    required this.setValue,
  });

  @override
  State<CustomDateFormInput> createState() => _CustomDateFormInputState();
}

class _CustomDateFormInputState extends State<CustomDateFormInput> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

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
          TextField(
            controller: dateController,
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
            readOnly: true,
            onTap: () async {
              // Function to show the devices native calender widget to select a date
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                widget.setValue(formattedDate);

                setState(() {
                  dateController.text = formattedDate;
                });
              } else {}
            },
          )
        ],
      ),
    );
  }
}
