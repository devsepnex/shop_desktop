import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop/core/api/api_manager.dart';
import 'package:shop/core/constants/live_date.dart';
import 'package:shop/core/widgets/error_dialog_widget.dart';
import 'package:shop/screens/DashBoard/dashboard_screen.dart';

class OtpProvider extends ChangeNotifier {
  final int otpLength = 6; // تعداد فیلدهای OTP
  final String username;
  final String password;
  late ApiManager apiManager;

  // لیست کنترلرها و فوکوس‌ها
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  FocusNode buttonFocusNode = FocusNode(); // فوکوس دکمه تأیید

  String errorMessage = ''; // برای نگهداری پیام خطا

  OtpProvider({required this.username,required this.password}) {
    apiManager = GetIt.I.get<ApiManager>();

    // ساخت کنترلرها و فوکوس‌ها
    for (int i = 0; i < otpLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  // جمع‌آوری کد OTP (ترتیب درست)
  String get otpCode {
    return controllers.reversed.map((controller) => controller.text).join();
  }

  // جابجایی فوکوس به فیلد بعدی یا قبلی (از راست به چپ)
  void moveToNextFieldReverse(BuildContext context, String value, int index) {
    if (value.isNotEmpty && index > 0) {
      // حرکت به فیلد سمت چپ
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    } else if (value.isEmpty && index < otpLength - 1) {
      // حرکت به فیلد سمت راست
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (index == 0 && value.isNotEmpty) {
      // وقتی آخرین فیلد پر شد
      FocusScope.of(context).requestFocus(buttonFocusNode);
    }
  }

  // اعتبارسنجی کد تایید
  bool validateOtp(String otp) {
    if (otp.isEmpty) {
      errorMessage = 'لطفا کد تأیید را وارد کنید';
      notifyListeners();
      return false;
    } else if (otp.length != otpLength) {
      errorMessage = 'کد تأیید باید 6 رقم باشد';
      notifyListeners();
      return false;
    } else {
      errorMessage = ''; // پاک کردن خطای قبلی
      notifyListeners();
      return true;
    }
  }

  // ورود به سیستم (ارسال درخواست به سرور)
  Future<void> login(BuildContext context) async {
    try {
      final body = {
        'login_data': username,
        'code': otpCode, // ارسال کد OTP به صورت یکجا
      };

      Response? response = await apiManager.post(
        path: 'server/login-admin-check',
        body: body,
      );

      final statusCode = response?.statusCode ?? 0;
      if (statusCode >= 200 && statusCode < 300) {
        final data = response?.data;
        if (data != null && data['has_error'] == false) {
          final payload = data['payload'];
          LiveData.accessToken = payload['access_token'];
          LiveData.expire = payload['expire'];
          LiveData.refreshToken = payload['refresh_token'];
          LiveData.username = payload['user']['username'];
          LiveData.firstName = payload['user']['first_name'];
          LiveData.lastName = payload['user']['last_name'];
          LiveData.role = payload['user']['role']; // ذخیره کردن نقش از سرور

          var role = LiveData.role; // استفاده از نقش دریافتی از سرور
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardScreen(role: role!),
                  settings: RouteSettings(arguments: role)));
        } else {
          showErrorDialog(context, data?['message'] ?? 'خطای ناشناخته.');
        }
      } else {
        showErrorDialog(context, 'خطای ناشناخته، لطفاً دوباره تلاش کنید.');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final response = e.response;
        final errorMessage = response?.data?['message'] ?? 'خطای سرور.';
        showErrorDialog(context, errorMessage);
      } else {
        showErrorDialog(context, 'خطای شبکه، لطفاً دوباره تلاش کنید.');
      }
    } catch (e) {
      showErrorDialog(context, 'خطای ناشناخته، لطفاً دوباره تلاش کنید.');
    }
  }

  // پاک کردن مقادیر OTP
  void clearOtp() {
    for (var controller in controllers.reversed) {
      controller.clear();
    }
    errorMessage = '';
    notifyListeners();
  }

  // تخلیه منابع
  @override
  void dispose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    buttonFocusNode.dispose(); // حذف فوکوس دکمه
    super.dispose();
  }

 newcode(BuildContext context) async {
   
    notifyListeners();

    try {
      final body = {
        'login_data': username,
        'password': password,
      };

      Response? response = await apiManager.post(
        path: 'server/login-admin-request',
        body: body,
      );

      // بررسی وضعیت پاسخ از سرور
      if (response?.statusCode == 200) {
      
      
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final response = e.response;
        if (response != null) {
          final errorMessage = response.data['message'] ?? 'خطای نامشخص';
          showErrorDialog(context, errorMessage);
        } else {
          showErrorDialog(context, 'خطای ناشناخته از سمت سرور.');
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        showErrorDialog(context, 'اتصال به سرور امکان‌پذیر نیست. لطفاً دوباره تلاش کنید.');
      } else {
        showErrorDialog(context, 'خطای شبکه، لطفاً دوباره تلاش کنید.');
      }
    } catch (e) {
      print('Unhandled Error: $e');
      showErrorDialog(context, 'خطای ناشناخته، لطفاً دوباره تلاش کنید.');
    } 
  }
 
}
