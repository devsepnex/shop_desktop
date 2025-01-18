
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/constants/app_color.dart';
import 'otp_provider.dart';

class OtpScreen extends StatelessWidget {
  final String username;

  const OtpScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtpProvider(username: username),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 33, 23, 57).withOpacity(0.99),
                const Color.fromARGB(255, 38, 20, 81).withOpacity(0.99),
                const Color.fromARGB(255, 59, 32, 132).withOpacity(0.6),
                Colors.white.withOpacity(0.7),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white12.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: Consumer<OtpProvider>(
                      builder: (context, otpProvider, child) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Flexible(
                              //   flex: 3,
                              //   child: Container(
                              //     width: MediaQuery.of(context).size.width * 0.3,
                              //     height: MediaQuery.of(context).size.height * 0.3,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(16),
                              //       image: DecorationImage(
                              //         image: AssetImage('images/otp2.jpg'),
                              //         fit: BoxFit.contain,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 16),
                              Text(
                                'کد تأیید',
                                style: TextStyle(
                                  color: AppColor.baseColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'vazir',
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'کد به شماره ${username} ارسال شده است',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'vazir',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  otpProvider.otpLength,
                                  (index) => _buildOtpField(context, index, otpProvider),
                                ).reversed.toList(),
                              ),
                              if (otpProvider.errorMessage.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    otpProvider.errorMessage,
                                    style: TextStyle(color: Colors.red, fontSize: 14),
                                  ),
                                ),
                              SizedBox(height: 24),
                              ElevatedButton(
                                focusNode: otpProvider.buttonFocusNode,
                                onPressed: () {
                                  if (otpProvider.errorMessage.isEmpty) {
                                    otpProvider.login(context);
                                  }
                                },
                                child: Text('تأیید'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 15.0),
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color.fromARGB(255, 38, 20, 81)
                                      .withOpacity(0.99),
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width > 610
                                          ? 280
                                          : MediaQuery.of(context).size.width * 0.9,
                                      51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              SizedBox(height: 18),
                              TextButton(
                                onPressed: () {
                                  otpProvider.clearOtp();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'ویرایش شماره',
                                  style: TextStyle(
                                      fontSize: 12, color: AppColor.baseColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(BuildContext context, int index, OtpProvider otpProvider) {
    int reverseIndex = otpProvider.otpLength - 1 - index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: 40,
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.backspace) {
              if (otpProvider.controllers[reverseIndex].text.isEmpty) {
                if (reverseIndex < otpProvider.otpLength - 1) {
                  FocusScope.of(context)
                      .requestFocus(otpProvider.focusNodes[reverseIndex + 1]);
                }
              }
            }
          },
          child: TextField(
  controller: otpProvider.controllers[reverseIndex],
  focusNode: otpProvider.focusNodes[reverseIndex],
  textAlign: TextAlign.center,
  keyboardType: TextInputType.number,
  maxLength: 1,
  style: TextStyle(
    color: Colors.white, // رنگ نوشته‌ها
    fontSize: 18,        // اندازه فونت نوشته‌ها
  ),
          // child: TextField(
          //   controller: otpProvider.controllers[reverseIndex],
          //   focusNode: otpProvider.focusNodes[reverseIndex],
          //   textAlign: TextAlign.center,
          //   keyboardType: TextInputType.number,
          //   maxLength: 1,
            //decoration:  InputDecoration(
            //   counterText: '',
            //   border: OutlineInputBorder(
            //     borderSide: BorderSide(color: AppColor.baseColor),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   filled: true,
            //   fillColor: Colors.white.withOpacity(0.2),
            // ),
            decoration: InputDecoration(
  counterText: '',
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // حاشیه پیش‌فرض
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white.withOpacity(0.8)), // حاشیه در حالت فوکوس
    borderRadius: BorderRadius.circular(8),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // حاشیه در حالت غیر فوکوس
    borderRadius: BorderRadius.circular(8),
  ),
  filled: true,
  fillColor: Colors.white.withOpacity(0.2),
),

            onChanged: (value) {
              if (value.isNotEmpty) {
                otpProvider.moveToNextFieldReverse(context, value, reverseIndex);
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputAction: (reverseIndex == 0)
                ? TextInputAction.done
                : TextInputAction.next,
            onSubmitted: (value) {
              if (reverseIndex == 0) {
                FocusScope.of(context).requestFocus(otpProvider.buttonFocusNode);
              }
            },
          ),
        ),
      ),
    );
  }
}
