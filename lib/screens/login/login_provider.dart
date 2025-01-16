import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop/core/api/api_manager.dart';
import 'package:shop/core/widgets/error_dialog_widget.dart';
import 'package:shop/screens/otp/otp_screen.dart';


class LoginProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late ApiManager apiManager;
  bool isPasswordVisible = false;
  bool isLoading = false; 

  LoginProvider() {
    apiManager = GetIt.I.get<ApiManager>();
  }

  login(BuildContext context) async {
    isLoading = true; 
    notifyListeners();

    try {
      final body = {
        'login_data': usernameController.text,
        'password': passwordController.text,
      };

      Response? response = await apiManager.post(
        path: 'server/login-admin-request',
        body: body,
      );

      // بررسی وضعیت پاسخ از سرور
      if (response?.statusCode == 200) {
        //final data = response?.data;

        // پیام موفقیت را ذخیره یا نمایش دهید (در صورت نیاز)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              username: usernameController.text,
            ),
          ),
        );
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
    } finally {
      isLoading = false; // پایان لودینگ
      notifyListeners();
    }
  }

  // متد برای تغییر وضعیت نمایش رمز عبور
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  
}
