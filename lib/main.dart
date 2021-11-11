import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:skm_services/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:skm_services/features/document/presentation/bloc/document_bloc.dart';
import 'dependencies.dart';
import 'features/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeIoC();

  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerBloc>(
          create: (_) => get<CustomerBloc>(),
        ),
        BlocProvider<DocumentBloc>(
          create: (_) => get<DocumentBloc>(),
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
