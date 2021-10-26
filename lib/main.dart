import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skm_services/features/customer/presentation/bloc/customer_bloc.dart';
import 'dependencies.dart';
import 'features/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeIoC();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerBloc>(
          create: (_) => get<CustomerBloc>(),
        ),
      ],
      child: MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Lato",
        ),
      ),
    );
  }
}
