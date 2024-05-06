import 'package:manager_projects_app/ui/provider/project_provider.dart';
import 'package:manager_projects_app/ui/provider/project_select_provider.dart';
import 'package:manager_projects_app/ui/provider/task_select_provider.dart';
import 'package:manager_projects_app/ui/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultipleProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ProjectProvider()),
    ChangeNotifierProvider(create: (_) => ProjectSelectProvider()),
    ChangeNotifierProvider(create: (_) => TaskSelectProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ];
}
