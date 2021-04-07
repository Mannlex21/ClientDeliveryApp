import 'package:client_delivery_app/src/bloc/login/login_bloc.dart';
import 'package:client_delivery_app/src/bloc/login/login_event.dart';
import 'package:client_delivery_app/src/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String email = "";
  String password = "";
  String errorMessage = "";
  bool showPassword = false;

  FocusNode emailFocus;
  FocusNode passwordFocus;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          setState(() {
            errorMessage = state.message;
          });
        }

        if (state is LoginSuccess) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacementNamed('/home');
          });
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 35, left: 35, bottom: 10, top: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Login client",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(labelText: "Correo"),
                                controller: _emailController,
                                focusNode: emailFocus,
                                onEditingComplete: () => requestFocus(context, passwordFocus),
                                textInputAction: TextInputAction.next,
                                onSaved: (value) {
                                  email = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Este campo es obligatorio";
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Contraseña",
                                  suffixIcon: IconButton(
                                    icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !showPassword,
                                controller: _passwordController,
                                focusNode: passwordFocus,
                                onEditingComplete: () => _login(context, state),
                                onSaved: (value) {
                                  password = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Este campo es obligatorio";
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              if (errorMessage.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                    errorMessage,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Iniciar Sesión'),
                                  ],
                                ),
                                onPressed: () => _login(context, state),
                                style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                    TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("¿No estas registrado?"),
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle: MaterialStateProperty.all(
                                        TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    child: Text("Registrarse"),
                                    onPressed: () => _showRegister(context),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    this._emailController.dispose();
    this._passwordController.dispose();

    emailFocus.dispose(); // NOTA: siempre borrar variables en dispose para liberar memoria
    passwordFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/registration');
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future<void> _login(BuildContext context, state) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      setState(() {
        errorMessage = "";
      });

      _loginBloc.add(Authentication(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }
}
