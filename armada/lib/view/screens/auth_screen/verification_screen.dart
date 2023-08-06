import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../../networkhandler.dart';
import '../../../utils/helper_widget.dart';

class Verify extends StatefulWidget {
  static const String routeName = '/verify';
  const Verify({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const Verify();
      },
    );
  }

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();

  String _userEnteredOTP = '';
  int _remainingSeconds = 60;
  bool _isCountdownActive = false;

  late Timer _countdownTimer;
  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // Start the countdown timer
    startCountdown();
  }

  void startCountdown() {
    setState(() {
      _isCountdownActive = true;
    });

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          stopCountdown();
        }
      });
    });
  }

  void stopCountdown() {
    setState(() {
      _isCountdownActive = false;
    });

    _countdownTimer.cancel();
  }

  void resendOTP() {
    setState(() {
      _remainingSeconds = 60;
    });

    startCountdown();
  }

  @override
  void dispose() {
    super.dispose();

    _countdownTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(89),
              Center(
                child: Text("Verify Your Phone.",
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              addVerticalSpace(60),
              Center(
                child: Text(
                    "Enter the verification OTP sent\n       to your phone number.",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              addVerticalSpace(45),
              Form(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      verifyInputBox(context, _otpController1),
                      verifyInputBox(context, _otpController2),
                      verifyInputBox(context, _otpController3),
                      verifyInputBox(context, _otpController4),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(32),

              Text(
                _isCountdownActive
                    ? 'Resend OTP in $_remainingSeconds seconds'
                    : '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              addVerticalSpace(26),
              if (!_isCountdownActive)
                Text(
                  "Did't recieve the code?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              addVerticalSpace(1.0),
              if (!_isCountdownActive)
                GestureDetector(
                  onTap: () {
                    resendOTP();
                  },
                  child: Text(
                    "Resend",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              addVerticalSpace(126),
              // Button(context, "Verify", '/VerifyFarm',
              //     Theme.of(context).primaryColor, 150, 55),
              InkWell(
                onTap: () async {
                  _userEnteredOTP = _otpController1.text +
                      _otpController2.text +
                      _otpController3.text +
                      _otpController4.text;
                  // print(_userEnteredOTP);
                  String? phoneNumber = await storage.read(key: "phone");
                  Map<String, String> data = {
                    "phone": phoneNumber!,
                    "otp": _userEnteredOTP,
                  };
                  validateOTP(data);
                  // dispose();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 150,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget verifyInputBox(
      BuildContext context, TextEditingController controller) {
    return SizedBox(
      height: 68.0,
      width: 64.0,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        // onSaved: (p) {},
        style: Theme.of(context).textTheme.displayLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.green,
              )),
          contentPadding: EdgeInsets.only(bottom: 25),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.green,
              )),
        ),
      ),
    );
  }

  void validateOTP(Map<String, String> data) async {
    // Call an API endpoint to verify the OTP
    // You can use a third-party service like Twilio for this purpose
    var response = await networkHandler.postt("/api/auth/verify", data);
    if (response.statusCode == 200) {
      print("otp verifyed");
      Map<String, dynamic> output = json.decode(response.body);
      // String jsonString = json.encode(output);
      // print("yes");
      // print("Token: $output['Token']");
      // await storage.write(key: 'token', value: output['Token']);

      // await storage.write(key: 'userid', value: output['user_id']);
      // If the OTPs match, mark the user as verified
      // setUserVerified(true);
      await storage.write(key: 'token', value: output['Token']);

      String? tok = await storage.read(key: "token");
      print(tok);

      await storage.write(key: 'userid', value: output['user_id']);

      String? userid = await storage.read(key: "userid");
      print(userid);

      // Save the user details to the database
      // saveUserDetails(phoneNumber, fullName);
      // Navigate to the home page
      // Consumer<DropDownProvider>(builder: (context, value, child) {
      //   if (value.selectedAccount == "Farmer") {
      //     print(value.selectedAccount);
      //     return const VerifyFarm();
      //   } else if (value.selectedAccount == "Service Provider") {
      //     print(value.selectedAccount);
      //     return const VerifyServiceProvider();
      //   } else {
      //     return Container();
      //   }
      // });
      // VerifyFarm();
      BotToast.showText(
        text: "Welcome! You have successfully registered.",
        duration: Duration(seconds: 2),
        contentColor: Colors.white,
        textStyle: TextStyle(fontSize: 16.0, color: Color(0xFF006837)),
      );
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
      // Navigator.pushNamed(context, '/VerifyFarm');
    } else {
      // If the OTPs do not match, show an error message
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                content: const Text(
                  "Incorrect OTP",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        _otpController1.clear();
                        _otpController2.clear();
                        _otpController3.clear();
                        _otpController4.clear();
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              ));
    }
  }
}
