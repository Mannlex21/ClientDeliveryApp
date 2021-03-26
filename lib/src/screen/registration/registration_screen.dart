import 'package:client_delivery_app/src/bloc/company_type_bloc.dart';
import 'package:client_delivery_app/src/model/CompanyType.dart';
import 'package:client_delivery_app/src/repository/company_type_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client_delivery_app/src/bloc/company_type_state.dart';
import 'package:client_delivery_app/src/bloc/company_type_event.dart';

class RegistrationScreen extends StatefulWidget {
  final BuildContext context;

  RegistrationScreen(this.context, {Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _companyController = TextEditingController();
  final _companyAddressController = TextEditingController();
  final _floorOfficeController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String company = "";
  String companyAddress = "";
  String floorOffice = "";
  String name = "";
  String lastName = "";
  String email = "";
  String password = "";
  String phoneNumber = "";
  String errorMessage = "";
  String companyType = "";
  bool showPassword = false;

  FocusNode companyFocus;
  FocusNode companyAddressFocus;
  FocusNode floorOfficeFocus;
  FocusNode nameFocus;
  FocusNode lastNameFocus;
  FocusNode emailFocus;
  FocusNode passwordFocus;
  FocusNode phoneNumberFocus;
  final companyTypeBloc = new CompanyTypeBloc();
  List<CompanyType> listCompanyType = [];
  final CompanyTypeRepository _companyTypeRepository = CompanyTypeRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompanyTypeBloc>(
      create: (context) => CompanyTypeBloc(companyTypeRepository: _companyTypeRepository)..add(CompanyTypeLoad()),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: const Color(0xFFF9F9F9),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Registration",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Nombre del negocio:"),
                    controller: _companyController,
                    focusNode: companyFocus,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () => requestFocus(context, passwordFocus),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      company = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Este campo es obligatorio";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Dirección del negocio:"),
                    controller: _companyAddressController,
                    focusNode: companyAddressFocus,
                    keyboardType: TextInputType.streetAddress,
                    onEditingComplete: () => requestFocus(context, passwordFocus),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      companyAddress = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Este campo es obligatorio";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Piso/Oficina (opcional):"),
                    controller: _floorOfficeController,
                    focusNode: floorOfficeFocus,
                    keyboardType: TextInputType.streetAddress,
                    onEditingComplete: () => requestFocus(context, passwordFocus),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      floorOffice = value;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Nombre:"),
                            controller: _nameController,
                            focusNode: nameFocus,
                            keyboardType: TextInputType.name,
                            onEditingComplete: () => requestFocus(context, passwordFocus),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              name = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo es obligatorio";
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Apellido:"),
                            controller: _lastNameController,
                            focusNode: lastNameFocus,
                            keyboardType: TextInputType.name,
                            onEditingComplete: () => requestFocus(context, passwordFocus),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              lastName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo es obligatorio";
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Email:"),
                    controller: _emailController,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
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
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Número de teléfono móvil:",
                    ),
                    style: TextStyle(fontSize: 16),
                    controller: _phoneNumberController,
                    focusNode: phoneNumberFocus,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () => requestFocus(context, passwordFocus),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      phoneNumber = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Este campo es obligatorio";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Contraseña:",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    style: TextStyle(fontSize: 16),
                    obscureText: !showPassword,
                    controller: _passwordController,
                    focusNode: passwordFocus,
                    // onEditingComplete: () => _login(context),
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
                    height: 5,
                  ),
                  Container(
                    child: BlocBuilder<CompanyTypeBloc, CompanyTypeState>(builder: (context, state) {
                      if (state is CompanyTypeLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CompanyTypeNoLoaded) {
                        return Center(
                          child: Column(
                            children: <Widget>[Icon(Icons.error), Text('Cannot load posts')],
                          ),
                        );
                      }
                      if (state is CompanyTypeLoaded) {
                        listCompanyType = state.companyTypeList;
                        if (listCompanyType.length > 0) {
                          return Container(
                            height: 50,
                            child: dropDown(listCompanyType),
                          );
                        } else {
                          return Container(
                            child: Center(
                              child: Text('No Blog Avaliable'),
                            ),
                          );
                        }
                      }
                      return Container();
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Registrar'),
                      ],
                    ),
                    onPressed: () => _registration(context),
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDown(List<CompanyType> list) {
    return DropdownButton<String>(
      value: companyType.isEmpty ? null : companyType,
      hint: new Text(
        "Tipo de empresa",
        style: TextStyle(color: Colors.grey[700]),
      ),
      underline: Container(
        height: 1.4,
        color: Colors.grey[400],
      ),
      isExpanded: true,
      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
      items: list.map((CompanyType value) {
        return new DropdownMenuItem<String>(
          value: value.id,
          child: new Text(value.name),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          companyType = listCompanyType.isEmpty ? value : listCompanyType.firstWhere((item) => item.id == value).id;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    this._emailController.dispose();
    this._passwordController.dispose();
    this._companyController.dispose();
    this._companyAddressController.dispose();
    this._floorOfficeController.dispose();
    this._nameController.dispose();
    this._lastNameController.dispose();
    this._phoneNumberController.dispose();
    companyTypeBloc.close();

    emailFocus.dispose();
    passwordFocus.dispose();
    companyFocus.dispose();
    companyAddressFocus.dispose();
    floorOfficeFocus.dispose();
    nameFocus.dispose();
    lastNameFocus.dispose();
    phoneNumberFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    companyFocus = FocusNode();
    companyAddressFocus = FocusNode();
    floorOfficeFocus = FocusNode();
    nameFocus = FocusNode();
    lastNameFocus = FocusNode();
    phoneNumberFocus = FocusNode();
    companyType = '';
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future<void> _registration(BuildContext context) async {
    try {
      if (_formKey.currentState.validate()) {
        setState(() {
          errorMessage = "";
        });

        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (userCredential != null) {
          Navigator.of(context).pushNamed('/login');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    // if (!_loading) {
    //   if (_formKey.currentState.validate()) {
    //     _formKey.currentState.save();
    //     setState(() {
    //       _loading = true;
    //       errorMessage = "";
    //     });

    //     User user = await widget.serverController.login(username, password);
    //     if (user != null) {
    //       setState(() {
    //         _loading = false;
    //       });
    //       Navigator.of(context).pushReplacementNamed('/home', arguments: user); // con el pushReplacementNamed no apareceria el boton de retroceso
    //     } else {
    //       setState(() {
    //         _loading = false;
    //         errorMessage = "Usuario o contraseña incorrecto";
    //       });
    //     }
    //   }
    // }
  }
}
