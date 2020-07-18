import 'package:get_it/get_it.dart';
import 'package:table_tennis_statistics/core/services/Api.dart';
import 'package:table_tennis_statistics/core/view/CRUDModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('matches'));
  locator.registerLazySingleton(() => CRUDModel());
}
