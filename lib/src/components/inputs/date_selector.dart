import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  final Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("24-02-2022 9:00 - 24-02-2022 17:00 "),
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.any(interactiveStates.contains)) {
                  return const Color.fromRGBO(182, 187, 193, 0.25);
                }
              },
            ),
          ),
          onPressed: () {
            print("Change Pressed");
          },
          child: const Text(
            "Change",
            style: TextStyle(color: Color.fromRGBO(27, 131, 139, 1)),
          ),
        ),
      ],
    );
  }
}
