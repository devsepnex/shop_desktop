import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shop/core/constants/address.dart';
import 'package:shop/core/constants/live_date.dart';
import 'package:shop/core/models/refresh_model.dart';

class ApiManager {
  late Dio dio;
  RefreshModel? refreshModel;
  ApiManager() {
    //base option
    BaseOptions _option = BaseOptions(baseUrl: baseUrl);
    dio = Dio(_option);
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true
    ));
    dio.options.headers = {
      'x-api-key':'93c8b887-afb4-46a2-9398-aa88f635cafb',
    };
  }

  Future<bool> getRefreshToken() async {
    try {
      Response response = await dio.get('server/refresh',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${LiveData.refreshToken}',
            },
          ));
      Map<String, dynamic> json = response.data;
      refreshModel = RefreshModel.fromJson(json);
      LiveData.accessToken = refreshModel!.token;
      LiveData.expire = refreshModel!.expire;
      return true;
    } on DioException catch (e) {
      print('${e.message}');
      return false;
    } catch (e) {
      print('error $e');
      return false;
    }
  }

  Future<Response?> post({required String path, required Map body}) async {
    // چک انقضای توکن
    int expireTime = LiveData.expire ?? 0;
    int now = DateTime.now().millisecondsSinceEpoch;

// زمان انقضا بزرگتر و توکن اعتبار داره

    if (expireTime == 0) {
      return _post(path: path, body: body);
    } else {
      if (now < expireTime) {
        return _post(path: path, body: body);
      } else {
        if (await getRefreshToken()) {
          return _post(path: path, body: body);
        }else {
          return null;
        }
      }
    }
  }
  Future<Response?> _post({required String path, required Map body})async{
    try{
      return dio.post(path,
          data: body,
          options: Options(
              headers: {'Authorization': 'Bearer ${LiveData.accessToken}'}));
    } on DioException catch(_){
      return null;
    }  catch(_){
      return null;
    }
  }

  Future<Response?> get({required String path,Map<String, dynamic>? queryParameters,}) async {
    // چک انقضای توکن
    int expireTime = LiveData.expire ?? 0;
    int now = DateTime.now().millisecondsSinceEpoch;

// زمان انقضا بزرگتر و توکن اعتبار داره

    if (expireTime == 0 ) {
      return _get(path: path,queryParameters: queryParameters);
    } else {
      if (now < expireTime) {
        return _get(path: path,queryParameters: queryParameters);
      } else {
        if (await getRefreshToken()) {
          return _get(path: path, queryParameters: queryParameters);
        }else {
          return null;
        }
      }
    }
  }
  Future<Response?> _get({required String path, Map<String, dynamic>? queryParameters})async{
    try{
      return dio.get(path,
      queryParameters: queryParameters,
          options: Options(
              headers: {'Authorization': 'Bearer ${LiveData.accessToken}'}));
    } on DioException catch(_){
      return null;
    }  catch(_){
      return null;
    }
  }
}
