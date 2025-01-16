
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/constants/app_color.dart';
import 'login_provider.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: AppColor.TertiaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage('images/Asset 7.png'),
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
                  child: loginForm(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginForm(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // تعریف فوکوس‌ها
    final focusNodeUsername = FocusNode();
    final focusNodePassword = FocusNode();

    return Form(
      key: context.read<LoginProvider>().formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ورود به حساب',
            style: TextStyle(
              color: AppColor.mainColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              width: screenWidth > 600 ? 400 : screenWidth * 0.9,
              child: TextFormField(
                controller: context.read<LoginProvider>().usernameController,
                focusNode: focusNodeUsername,
                decoration: InputDecoration(
                  labelText: 'شماره تلفن',
                  hintText: 'شماره تلفن خود را وارد کنید',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: AppColor.mainColor),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  // اجازه فقط وارد کردن اعداد و محدودیت طول ورودی به 11 رقم
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(focusNodePassword);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفا شماره تلفن خود را وارد کنید';
                  }
                  if (value.length != 11) {
                    return 'شماره تلفن باید 11 رقم باشد';
                  }
                  if (!value.startsWith('09')) {
                    return 'شماره تلفن باید با 09 شروع شود';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              width: screenWidth > 600 ? 400 : screenWidth * 0.9,
              child: Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return TextFormField(
                    controller: provider.passwordController,
                    focusNode: focusNodePassword,
                    obscureText: !provider.isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'رمز عبور',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: AppColor.mainColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          provider.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColor.mainColor,
                          size: 15,
                        ),
                        onPressed: () {
                          provider.togglePasswordVisibility();
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      if (provider.formKey.currentState!.validate()) {
                        provider.login(context);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لطفا رمز عبور خود را وارد کنید';
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 24),
          Consumer<LoginProvider>(
            builder: (context, provider, child) {
              return provider.isLoading
                  ? CircularProgressIndicator() 
                  : ElevatedButton(
                      onPressed: () {
                        if (context.read<LoginProvider>().formKey.currentState!.validate()) {
                          context.read<LoginProvider>().login(context);
                        }
                      },
                      child: Text('درخواست کد'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                        foregroundColor: Colors.white,
                        backgroundColor: AppColor.mainColor,
                        minimumSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}


