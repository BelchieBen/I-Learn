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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromRGBO(27, 131, 139, 1),
              secondary: const Color.fromRGBO(182, 187, 193, 1),
            ),
      ),
      child: Stepper(
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
                child: const Text('Content for Step 1')),
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
                const DateSelector(),
                const BookingForm()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
