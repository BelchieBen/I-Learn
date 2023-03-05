import 'package:booking_app/src/components/course/course_information.dart';
import 'package:booking_app/src/components/forms/booking_form.dart';
import 'package:booking_app/src/components/inputs/text_form_input.dart';
import 'package:booking_app/src/components/scaffold/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingStepper extends StatefulWidget {
  final Map<String, dynamic> course;
  const BookingStepper({
    super.key,
    required this.course,
  });

  @override
  State<BookingStepper> createState() => _BookingStepperState();
}

class _BookingStepperState extends State<BookingStepper> {
  final supabase = Supabase.instance.client;
  int _index = 0;
  int selectedDateIndex = 0;
  bool loadingSessions = false;
  bool submittingBooking = false;

  String? howIdentified;
  String? howApply;
  String? howMeasure;

  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List dates = [];

  @override
  void initState() {
    super.initState();
    SupabaseClient supabase = Supabase.instance.client;
    _fetchCourseSessions(supabase);
  }

  void _fetchCourseSessions(SupabaseClient supabase) async {
    setState(() => loadingSessions = true);
    final sessions = await supabase
        .from("sessions")
        .select("*")
        .filter("course_id", "eq", widget.course["id"]!);

    setState(() {
      dates = sessions;
      loadingSessions = false;
    });
  }

  bool _assertNotEmpty() {
    if (howIdentified != null && howApply != null && howMeasure != null) {
      return true;
    }
    return false;
  }

  void _submitBooking() async {
    setState(() => submittingBooking = true);
    final response = await supabase.from("user_bookings").insert({
      "employee": supabase.auth.currentUser?.id,
      "session": dates[selectedDateIndex]["id"]!,
      "status": "Pending"
    });
    setState(() => submittingBooking = false);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        successSnackbar(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AppScaffold(),
        ),
      );
    }
  }

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
              formKey.currentState!.save();
              if (_assertNotEmpty()) {
                _submitBooking();
              }
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: dates.isEmpty
                      ? const SizedBox.shrink()
                      : Text(dates[selectedDateIndex]["start_date"]! +
                          " " +
                          dates[selectedDateIndex]["start_time"]! +
                          " - " +
                          dates[selectedDateIndex]["end_date"]! +
                          " " +
                          dates[selectedDateIndex]["end_time"]!),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormInput(
                        labelText: "How has this training been identified?",
                        numLines: 3,
                        isDense: false,
                        obscureText: false,
                        setValue: (value) => setState(() {
                          howIdentified = value;
                        }),
                      ),
                      TextFormInput(
                        labelText:
                            "How will you apply the learning in your role?",
                        numLines: 3,
                        isDense: false,
                        obscureText: false,
                        setValue: (value) => setState(() {
                          howApply = value;
                        }),
                      ),
                      TextFormInput(
                        labelText:
                            "How will you measure the success of this learning?",
                        numLines: 3,
                        isDense: false,
                        obscureText: false,
                        setValue: (value) => setState(() {
                          howMeasure = value;
                        }),
                      ),
                    ],
                  ),
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
        loadingSessions
            ? const SizedBox(
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Color.fromRGBO(5, 109, 120, 1),
                  ),
                ),
              )
            : dates.isEmpty && !loadingSessions
                ? const SizedBox(
                    width: double.infinity,
                    child: Center(child: Text("No Sessions Available")),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: dates.isEmpty ? 0 : dates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        title: Text(dates[index]["start_date"]! +
                            ": " +
                            dates[index]["start_time"]!.substring(0, 5) +
                            " - " +
                            dates[index]["end_date"]! +
                            ": " +
                            dates[index]["end_time"]!.substring(0, 5)),
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
                onPressed: submittingBooking ? null : details.onStepContinue,
                child: dates.isEmpty
                    ? const SizedBox.shrink()
                    : submittingBooking
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(strokeWidth: 1),
                          )
                        : Text(isLastStep ? 'Submit' : 'Next'))),
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

  SnackBar successSnackbar() {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 60,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 184, 110, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.check_circle_outline,
              color: Color.fromRGBO(167, 251, 217, 1),
            ),
            SizedBox(width: 6),
            Text("Booking Submitted"),
          ],
        ),
      ),
    );
  }
}
