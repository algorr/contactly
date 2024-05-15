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
    /// This code snippet is the main entry point of a Flutter application.
    return MultiBlocProvider(
      providers: [
        /// `BlocProvider(
        ///   create: (context) => ContactCubit(),
        /// ),` is a part of the Flutter Bloc library that provides a specific instance of a Bloc to the
        /// widget tree. In this case, it is providing an instance of the `ContactCubit` to the widget
        /// tree so that it can be accessed by the widgets within that tree. The `create` parameter is a
        /// callback function that is responsible for creating the instance of the `ContactCubit` when
        /// it is needed. This allows the `ContactCubit` to be available for use by any child widgets
        /// that need to interact with it using the Bloc pattern.
        BlocProvider(
          create: (context) => ContactCubit(),
        ),

        /// The `BlocProvider<ServiceCubit>` in the provided code snippet is responsible for providing
        /// an instance of the `ServiceCubit` to the widget tree using the Flutter Bloc library. Here's
        /// what `BlocProvider<ServiceCubit>` with the `create` parameter is doing:
        BlocProvider<ServiceCubit>(
          create: (context) => ServiceCubit()..serviceInit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contactly',
        theme: getAppTheme(),
        home: const HomeView(),
      ),
    );
  }
}
