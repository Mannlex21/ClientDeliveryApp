import 'package:client_delivery_app/src/bloc/login/login_bloc.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_bloc.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_event.dart';
import 'package:client_delivery_app/src/bloc/registration/registration_bloc.dart';
import 'package:client_delivery_app/src/bloc/registration/registration_event.dart';
import 'package:client_delivery_app/src/repository/company_type_repository.dart';
import 'package:client_delivery_app/src/repository/login_repository.dart';
import 'package:client_delivery_app/src/repository/modifier_repository.dart';
import 'package:client_delivery_app/src/repository/registration_repository.dart';
import 'package:client_delivery_app/src/screen/home/home_screen.dart';
import 'package:client_delivery_app/src/screen/login/login_screen.dart';
import 'package:client_delivery_app/src/screen/modifier/add_modifier_screen.dart';
import 'package:client_delivery_app/src/screen/modifier/modifier_screen.dart';
import 'package:client_delivery_app/src/screen/registration/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final CompanyTypeRepository _companyTypeRepository = CompanyTypeRepository();
  final RegistrationRepository _registrationRepository = RegistrationRepository();
  final LoginRepository _loginRepository = LoginRepository();
  final ModifierRepository _modifierRepository = ModifierRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColor: Colors.red[300],
        accentColor: Colors.cyan[300],
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return BlocProvider(
                create: (context) => LoginBloc(loginRepository: _loginRepository),
                child: LoginScreen(),
              );
            case '/home':
              return MyHomeScreen();
            case '/modifier':
              return BlocProvider(
                create: (context) => ModifierBloc(modifierRepository: _modifierRepository)..add(ListModifier()),
                child: ModifierScreen(context),
              );
            case '/add_modifier':
              return BlocProvider(
                create: (context) => ModifierBloc(modifierRepository: _modifierRepository),
                child: AddModifierScreen(context),
              );
            case '/registration':
              return BlocProvider(
                create: (context) => RegistrationBloc(companyTypeRepository: _companyTypeRepository, registrationRepository: _registrationRepository)
                  ..add(CompanyTypeLoad()),
                child: RegistrationScreen(),
              );
            default:
              return BlocProvider(
                create: (context) => LoginBloc(loginRepository: _loginRepository),
                child: LoginScreen(),
              );
          }
        });
      },
    );
  }
}
