import 'package:booking_app/src/components/course/course_information.dart';
import 'package:booking_app/src/components/forms/booking_form.dart';
import 'package:booking_app/src/components/inputs/date_selector.dart';
import 'package:flutter/material.dart';

class BookingStepper extends StatefulWidget {
  final Map<String, String> course;
  const BookingStepper({
    super.key,
    required this.course,
  });

  @override
  State<BookingStepper> createState() => _BookingStepperState();
}

class _BookingStepperState extends State<BookingStepper> {
  int _index = 0;
  int selectedDateIndex = 0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> dates = [
    "12-01-2022 9:00 - 12-01-2022 17:00",
    "24-02-2022 9:00 - 24-02-2022 17:00",
  ];

  @override
  Widget build(BuildContext context) {
    final isLastStep = _index == 2 - 1;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return const Color.fromRGBO(139, 147, 154, 1);
      }
      return const Color.fromRGBO(182, 187, 193, 1);
    }

    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromRGBO(27, 131, 139, 1),
              secondary: const Color.fromRGBO(182, 187, 193, 1),
            ),
      ),
      child: Stepper(
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container(
            margin: const EdgeInsets.only(top: 50),
            child: stepperControlls(details, isLastStep, getColor),
          );
        },
        currentStep: _index,
        type: StepperType.horizontal,
        elevation: 0,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
            });
          }
          if (isLastStep) {
            if (formKey.currentState!.validate()) {
              // Process data.
            }
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: <Step>[
          Step(
            title: const Text('Select a Date'),
            state: (_index == 0)
                ? StepState.editing
                : (_index > 0)
                    ? StepState.complete
                    : StepState.indexed,
            isActive: _index >= 0,
            content: Container(
              alignment: Alignment.centerLeft,
              child: dateSelector(),
            ),
          ),
          Step(
            title: const Text('Submit Booking'),
            state: (_index == 1)
                ? StepState.editing
                : (_index > 1)
                    ? StepState.complete
                    : StepState.indexed,
            isActive: _index >= 1,
            content: Column(
              children: [
                CourseInformation(course: widget.course),
                DateSelector(
                  date: dates[selectedDateIndex],
                ),
                BookingForm(
                  formKey: formKey,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column dateSelector() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: dates.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              title: Text(dates[index]),
              trailing: selectedDateIndex == index
                  ? const Icon(
                      Icons.check_circle_outline,
                      color: Color.fromRGBO(92, 199, 208, 1),
                    )
                  : null,
              tileColor: selectedDateIndex == index
                  ? const Color.fromRGBO(210, 246, 250, 1)
                  : null,
              onTap: () {
                setState(() {
                  selectedDateIndex = index;
                });
              },
            );
          },
        ),
      ],
    );
  }

  Row stepperControlls(ControlsDetails details, bool isLastStep,
      Color getColor(Set<MaterialState> states)) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(isLastStep ? 'Submit' : 'Next'))),
        const SizedBox(
          width: 12,
        ),
        if (_index != 0)
          Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor),
                  ),
                  onPressed: details.onStepCancel,
                  child: const Text('Back')))
      ],
    );
  }
}
