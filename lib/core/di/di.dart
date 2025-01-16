import 'package:get_it/get_it.dart';
import 'package:shop/core/api/api_manager.dart';

 Future<void> di()async{
  GetIt getIt =GetIt.instance;
  getIt.registerSingleton<ApiManager>(ApiManager());

return await Future<void>.value(null);
}