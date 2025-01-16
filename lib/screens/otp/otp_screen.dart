
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
          padding: EdgeInsets.all(16),
          color: AppColor.TertiaryColor,
          child: Consumer<OtpProvider>(
            builder: (context, otpProvider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage('images/otp2.jpg'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'کد تأیید',
                            style: TextStyle(
                              color: AppColor.mainColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'کد به شماره ${username} ارسال شده است',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              otpProvider.otpLength,
                              (index) =>
                                  _buildOtpField(context, index, otpProvider),
                            ).reversed.toList(), // معکوس کردن لیست فیلدها
                          ),
                          // نمایش پیام خطا
                          if (otpProvider.errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                otpProvider.errorMessage,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
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
                              backgroundColor:
                                  AppColor.mainColor,
                              minimumSize: Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
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
                                  fontSize: 10, color: AppColor.mainColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
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
        focusNode: FocusNode(), // برای دریافت رویدادهای کیبورد
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            // وقتی Backspace زده شد و مقدار خالی بود
            if (otpProvider.controllers[reverseIndex].text.isEmpty) {
              if (reverseIndex < otpProvider.otpLength - 1) {
                // فوکوس به فیلد قبلی برود
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
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.white,
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
