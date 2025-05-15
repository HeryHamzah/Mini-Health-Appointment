import 'package:get_it/get_it.dart';

abstract class Injection {
  final di = GetIt.instance;
  void inject();
}
