import 'package:contactly/features/view/home/home_view.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/resources/index.dart';
import 'product/init/app_initialize.dart';

void main() {
  AppInitialize().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactCubit(),
        ),
        BlocProvider<ServiceCubit>(
          create: (context) => ServiceCubit()..fetchAllContacts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contactly',
        theme: getAppTheme(),
        home: HomeView(),
      ),
    );
  }
}
