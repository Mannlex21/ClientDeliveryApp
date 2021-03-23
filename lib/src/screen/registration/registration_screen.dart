import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String companyType = "Name1";
  bool showPassword = false;

  FocusNode companyFocus;
  FocusNode companyAddressFocus;
  FocusNode floorOfficeFocus;
  FocusNode nameFocus;
  FocusNode lastNameFocus;
  FocusNode emailFocus;
  FocusNode passwordFocus;
  FocusNode phoneNumberFocus;

  final List<String> nameList = <String>["Name1", "Name2", "Name3", "Name4", "Name5", "Name6", "Name7", "Name8"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 59,
                  child: DropdownButton(
                    isExpanded: true,
                    value: companyType.isNotEmpty ? companyType : null,
                    hint: new Text("Tipo de empresa"),
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onChanged: (value) {
                      setState(() {
                        companyType = nameList.isEmpty ? value : nameList.firstWhere((item) => item == value);
                      });
                    },
                    items: nameList.map(
                      (item) {
                        return DropdownMenuItem(
                          value: item,
                          child: new Text(item),
                        );
                      },
                    ).toList(),
                  ),
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
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    companyType = 'Name1';
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
