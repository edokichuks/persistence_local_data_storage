import 'package:get_it/get_it.dart';
import 'package:persistence_local_data_storage/src/ui/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/add_contact/add_contact_view.dart';

final locator = GetIt.instance;

@StackedApp(routes: [
  MaterialRoute(page: HomeView, initial: true),
  MaterialRoute(page: AddContactView),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: SnackbarService)
])
class AppClass {
  /**This class serves no purpose other than to annotate stackApp */
}
