import 'package:client_delivery_app/src/bloc/item/item_bloc.dart';
import 'package:client_delivery_app/src/bloc/item/item_event.dart';
import 'package:client_delivery_app/src/bloc/login/login_bloc.dart';
import 'package:client_delivery_app/src/bloc/menu/menu_bloc.dart_bloc.dart';
import 'package:client_delivery_app/src/bloc/menu/menu_event.dart_event.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_bloc.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_event.dart';
import 'package:client_delivery_app/src/bloc/registration/registration_bloc.dart';
import 'package:client_delivery_app/src/bloc/registration/registration_event.dart';
import 'package:client_delivery_app/src/repository/company_type_repository.dart';
import 'package:client_delivery_app/src/repository/item_repository.dart';
import 'package:client_delivery_app/src/repository/login_repository.dart';
import 'package:client_delivery_app/src/repository/menu_repository.dart';
import 'package:client_delivery_app/src/repository/modifier_repository.dart';
import 'package:client_delivery_app/src/repository/registration_repository.dart';
import 'package:client_delivery_app/src/screen/home/home_screen.dart';
import 'package:client_delivery_app/src/screen/items/form_item_screen.dart';
import 'package:client_delivery_app/src/screen/items/items_screen.dart';
import 'package:client_delivery_app/src/screen/login/login_screen.dart';
import 'package:client_delivery_app/src/screen/menu/form_menu_screen.dart';
import 'package:client_delivery_app/src/screen/menu/menu_screen.dart';
import 'package:client_delivery_app/src/screen/modifier/form_modifier_screen.dart';
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
  final MenuRepository _menuRepository = MenuRepository();
  final ItemRepository _itemRepository = ItemRepository();

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
            case '/menu':
              return BlocProvider(
                create: (context) => MenuBloc(menuRepository: _menuRepository)..add(ListMenu()),
                child: MenuScreen(context),
              );
            case '/items':
              return BlocProvider(
                create: (context) => ItemBloc(itemRepository: _itemRepository)..add(ListItem()),
                child: ItemsScreen(context),
              );
            case '/form_menu':
              return BlocProvider(
                create: (context) => ModifierBloc(modifierRepository: _modifierRepository),
                child: FormMenuScreen(context, modifier: settings.arguments),
              );
            case '/form_modifier':
              return BlocProvider(
                create: (context) => ModifierBloc(modifierRepository: _modifierRepository),
                child: FormModifierScreen(context, modifier: settings.arguments),
              );
            case '/form_item':
              return BlocProvider(
                create: (context) => ItemBloc(itemRepository: _itemRepository),
                child: FormItemScreen(context, modifier: settings.arguments),
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
