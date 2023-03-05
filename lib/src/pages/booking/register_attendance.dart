import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/scaffold/app_scaffold.dart';
import '../../util/resolve_header_color.dart';

class RegisterAttendance extends StatefulWidget {
  const RegisterAttendance({super.key});

  @override
  State<RegisterAttendance> createState() => _RegisterAttendanceState();
}

class _RegisterAttendanceState extends State<RegisterAttendance> {
  final SupabaseClient supabase = Supabase.instance.client;
  String _scanBarcode = "Unknown";
  bool submittingBooking = false;

  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    if (barcodeScanRes.isNotEmpty) {
      _submitBooking();
    }
  }

  void _submitBooking() async {
    setState(() => submittingBooking = true);
    try {
      final response = await supabase
          .from("user_bookings")
          .update({"status": "complete"})
          .match({"id": _scanBarcode!})
          .select("*,sessions(*,courses(*))")
          .single();
      setState(() {
        submittingBooking = false;
      });
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Welcome"),
            content: Text("You have registered your attendance for " +
                response["sessions"]["courses"]["title"]),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppScaffold(),
                    ),
                  );
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Color.fromRGBO(5, 109, 120, 1),
                  ),
                ),
              )
            ],
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackbar(),
      );
    }
  }

  AppBar appHeader() {
    return AppBar(
      title: const Text("Register Attendance"),
      backgroundColor: resolveAppHeaderColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color.fromRGBO(5, 109, 120, 1),
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: submittingBooking
                      ? null
                      : () {
                          scanQR();
                        },
                  child: submittingBooking
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 1),
                        )
                      : const Text(
                          "Register Attendance",
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SnackBar errorSnackbar() {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 60,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(226, 45, 56, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.error,
              color: Color.fromRGBO(255, 228, 230, 1),
            ),
            SizedBox(width: 6),
            Text("An error occurred, please try again"),
          ],
        ),
      ),
    );
  }
}
