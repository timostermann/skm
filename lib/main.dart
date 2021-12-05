import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:skm_services/src/presentation/blocs/customer/customer_bloc.dart';
import 'package:skm_services/src/presentation/blocs/document/document_bloc.dart';
import 'src/injector.dart';
import 'src/presentation/screens/home_screen.dart';

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
