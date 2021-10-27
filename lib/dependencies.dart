import 'package:get_it/get_it.dart';
import 'package:skm_services/models/cache.dart';

import 'features/customer/presentation/bloc/customer_bloc.dart';
import 'features/document/presentation/bloc/document_bloc.dart';
import 'features/sketch/presentation/bloc/mode_bloc.dart';
import 'features/sketch/presentation/bloc/sketch_bloc.dart';

// IoC = Inversion of Control
Future<void> initializeIoC() async {
  await _registerBlocs();
}

Future _registerBlocs() async {
  singleton<Cache>(() => Cache());
  factory<SketchBloc>(() => SketchBloc(get<Cache>()));
  factory<ModeBloc>(() => ModeBloc());
  factory<CustomerBloc>(() => CustomerBloc(get<Cache>()));
  factory<DocumentBloc>(() => DocumentBloc(get<Cache>()));
}

T get<T extends Object>({dynamic param}) {
  return getFunc<T>(param: param);
}

T Function<T extends Object>({dynamic param}) getFunc = _get;

T _get<T extends Object>({dynamic param}) {
  return GetIt.instance.get<T>(param1: param);
}

void singleton<T extends Object>(T Function() constructor, [void singleton]) {
  GetIt.instance.registerLazySingleton<T>(constructor);
}

void factory<T extends Object>(T Function() constructor) {
  GetIt.instance.registerFactory<T>(constructor);
}
