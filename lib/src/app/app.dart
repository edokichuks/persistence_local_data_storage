
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

@StackedApp(
  routes: [
  //     CupertinoRoute(
  //   page: AddContact(),
  // ),

],
dependencies: [
  LazySingleton(classType: NavigationService,)
])


class AppClass {
  /**This class serves no purpose other than to annotate stackApp */
}
