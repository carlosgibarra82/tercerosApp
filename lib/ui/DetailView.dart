import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tercerosApp/core/models/Nits.dart';
import 'package:tercerosApp/core/models/idType.dart';
import 'package:tercerosApp/core/services/api.dart';
import 'package:tercerosApp/core/services/app_state.dart';
import 'package:provider/provider.dart';

class DetailView extends StatefulWidget {
  DetailView({Key key}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _firstSurnameController = TextEditingController();
  final TextEditingController _secondSurnameController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _verificationDigitController =
      TextEditingController();
  final TextEditingController _aaController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();
  final TextEditingController _telexController = TextEditingController();

  List<IdType> _fetchidType = new List();
  IdType cc = new IdType();
  IdType nit = new IdType();
  String _selectedOption, nt;
  Nit tp;
  AppState appState;

  @override
  Widget build(BuildContext context) {
    return Container(child: _registerWithMail());
  }

  @override
  void initState() {
    appState = Provider.of<AppState>(context, listen: false);
    cc.code = 'CC';
    cc.description = 'Cédula de ciudadanía';
    nit.code = 'NT';
    nit.description = 'NIT';
    _fetchidType.add(cc);
    _fetchidType.add(nit);
    if (appState.getId != null) {
      load();
    }
    super.initState();
  }

  void load() async {
    tp = await fetchNit(appState.getId);
    _emailController.text = tp.dirElect;
    _phoneController.text = tp.tel;
    _firstNameController.text = tp.nom1;
    _secondNameController.text = tp.nom2;
    _firstSurnameController.text = tp.ape1;
    _secondSurnameController.text = tp.ape2;
    _nameController.text = tp.nom;
    _addressController.text = tp.dir;
    _userIDController.text = tp.nIde;
    _verificationDigitController.text = tp.dig;
    _aaController.text = tp.aa;
    _faxController.text = tp.fax;
    _telexController.text = tp.tlx;
    setState(() {
      _selectedOption = tp.ide;
    });
  }

  Widget _registerWithMail() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pushNamed(context, '/');
            }),
        title: Text("NIT"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.white,
                  ),
                  onPressed: () => deleteUser())),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(
                    Icons.save_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => saveUser()))
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _idtype(),
          _userID(context),
          _firstName(context),
          _secondName(context),
          _firstSurname(context),
          _secondSurname(context),
          _nombre(context),
          _userMail(context),
          _userAddress(context),
          _userPhone(context),
          _userFax(context),
          _userAA(context),
          _userTelex(context)
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _fetchidType.forEach((item) {
      lista.add(DropdownMenuItem(
        child: Text(item.description),
        value: item.code,
      ));
    });
    return lista;
  }

  Widget _idtype() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Icon(Icons.add_circle_outlined, color: Colors.black),
            SizedBox(width: 20),
            Flexible(
              child: DropdownButton(
                  isExpanded: true,
                  items: getOpcionesDropdown(),
                  value: _selectedOption,
                  onChanged: (opt) {
                    setState(() {
                      _selectedOption = opt;
                    });
                  }),
            ),
          ],
        ));
  }

  Widget _firstName(BuildContext context) {
    return Visibility(
      visible: _selectedOption == 'CC',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Este Campo no puede ser vacío';
            }
            return null;
          },
          controller: _firstNameController,
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            BlacklistingTextInputFormatter.singleLineFormatter,
          ],
          decoration: InputDecoration(
              icon: Icon(Icons.supervised_user_circle, color: Colors.black),
              hintText: 'Primer Nombre',
              labelText: 'Primer Nombre'),
        ),
      ),
    );
  }

  Widget _secondName(BuildContext context) {
    return Visibility(
      visible: _selectedOption == 'CC',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Este Campo no puede ser vacío';
            }
            return null;
          },
          controller: _secondNameController,
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            BlacklistingTextInputFormatter.singleLineFormatter,
          ],
          decoration: InputDecoration(
              icon: Icon(Icons.supervised_user_circle, color: Colors.black),
              hintText: 'Segundo Nombre',
              labelText: 'Segundo Nombre'),
        ),
      ),
    );
  }

  Widget _firstSurname(BuildContext context) {
    return Visibility(
      visible: _selectedOption == 'CC',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Este Campo no puede ser vacío';
            }
            return null;
          },
          controller: _firstSurnameController,
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            BlacklistingTextInputFormatter.singleLineFormatter,
          ],
          decoration: InputDecoration(
              icon: Icon(Icons.supervised_user_circle, color: Colors.black),
              hintText: 'Primer Apellido',
              labelText: 'Primer Apellido'),
        ),
      ),
    );
  }

  Widget _secondSurname(BuildContext context) {
    return Visibility(
      visible: _selectedOption == 'CC',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Este Campo no puede ser vacío';
            }
            return null;
          },
          controller: _secondSurnameController,
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            BlacklistingTextInputFormatter.singleLineFormatter,
          ],
          decoration: InputDecoration(
              icon: Icon(Icons.supervised_user_circle, color: Colors.black),
              hintText: 'Segundo Apellido',
              labelText: 'Segundo Apellido'),
        ),
      ),
    );
  }

  Widget _nombre(BuildContext context) {
    return Visibility(
      visible: _selectedOption == 'NT',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Este Campo no puede ser vacío';
            }
            return null;
          },
          controller: _nameController,
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            BlacklistingTextInputFormatter.singleLineFormatter,
          ],
          decoration: InputDecoration(
              icon: Icon(Icons.apartment, color: Colors.black),
              hintText: 'Nombre',
              labelText: 'Nombre'),
        ),
      ),
    );
  }

  Widget _userAddress(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Este Campo no puede ser vacío';
          }
          return null;
        },
        controller: _addressController,
        keyboardType: TextInputType.text,
        inputFormatters: <TextInputFormatter>[
          BlacklistingTextInputFormatter.singleLineFormatter,
        ],
        decoration: InputDecoration(
            icon: Icon(Icons.home, color: Colors.black),
            hintText: 'Dirección de Residencia',
            labelText: 'Dirección'),
      ),
    );
  }

  void calculateVerificationDigit(String value) {
    int par = 0, impar = 0, total = 0, counter = 0;
    if (value.length != 0) {
      List<String> digits = (value.split(''));
      digits.asMap().forEach((key, value) {
        if (key % 2 == 0) {
          impar = impar + (int.parse(value));
        } else
          par = par + (int.parse(value));
      });
      print("impar $impar");
      print("par $par");
      impar = impar * 3;

      total = impar + par;
      while (total % 10 != 0) {
        counter++;
        total++;
      }
      setState(() {
        _verificationDigitController.text = counter.toString();
      });
    } else {
      setState(() {
        _verificationDigitController.text = '';
      });
    }
  }

  Widget _userID(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: <Widget>[
        Flexible(
          flex: 2,
          child: TextFormField(
            onChanged: calculateVerificationDigit,
            validator: (value) {
              if (value.isEmpty) return 'Este Campo no puede ser vacío';
              return null;
            },
            controller: _userIDController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                icon: Icon(Icons.credit_card, color: Colors.black),
                hintText: 'Número de Identificación',
                labelText: 'Número de Identificación'),
          ),
        ),
        Flexible(
          child: TextFormField(
              readOnly: true,
              controller: _verificationDigitController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Digito', labelText: 'Digito')),
        )
      ]),
    );
  }

  Widget _userMail(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Este Campo no puede ser vacío';
          }
          return null;
        },
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter(RegExp(
              "^[a-zA-Z0-9_.+-]*(@([a-zA-Z0-9-]*(\\.[a-zA-Z0-9-]*)?)?)?\$")),
          BlacklistingTextInputFormatter.singleLineFormatter,
        ],
        decoration: InputDecoration(
            icon: Icon(Icons.alternate_email, color: Colors.black),
            hintText: 'usuario@mail.com',
            labelText: 'Correo Electrónico'),
      ),
    );
  }

  Widget _userPhone(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) return 'Este Campo no puede ser vacío';
          if (value.length < 6) return 'La Longitud mínima son 6 caracteres';
          return null;
        },
        controller: _phoneController,
        obscureText: false,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            icon: Icon(Icons.phone, color: Colors.black),
            labelText: 'Teléfono'),
      ),
    );
  }

  Widget _userFax(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) return 'Este Campo no puede ser vacío';
          if (value.length < 6) return 'La Longitud mínima son 6 caracteres';
          return null;
        },
        controller: _faxController,
        obscureText: false,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            icon: Icon(Icons.print, color: Colors.black), labelText: 'Fax'),
      ),
    );
  }

  Widget _userAA(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) return 'Este Campo no puede ser vacío';
          if (value.length < 6) return 'La Longitud mínima son 6 caracteres';
          return null;
        },
        controller: _aaController,
        obscureText: false,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            icon: Icon(Icons.account_box, color: Colors.black),
            labelText: 'Apartado aéreo'),
      ),
    );
  }

  Widget _userTelex(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) return 'Este Campo no puede ser vacío';
          if (value.length < 6) return 'La Longitud mínima son 6 caracteres';
          return null;
        },
        controller: _telexController,
        obscureText: false,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            icon: Icon(Icons.phone_callback, color: Colors.black),
            labelText: 'Telex'),
      ),
    );
  }

  deleteUser() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Nits'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Desea Borrar este NIT?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('SI'),
                onPressed: () async {
                  String response = await deleteNit(appState.getId);
                  if (response == "Success") {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('Nits'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Borrado con exito'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('ENTENDIDO'),
                                  onPressed: () async {
                                    String response =
                                        await deleteNit(appState.getId);
                                    if (response == "1") {
                                      print('ok');
                                    }
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/');
                                  },
                                ),
                              ],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))));
                        });
                    Navigator.pushNamed(context, '/');
                  }
                },
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))));
      },
    );
  }

  saveUser() async {
    if (_aaController.text != "" &&
        _emailController.text != "" &&
        _phoneController.text != "" &&
        _addressController.text != "" &&
        _userIDController.text != "" &&
        _verificationDigitController.text != "" &&
        _aaController.text != "" &&
        _faxController.text != "" &&
        _telexController.text != "" &&
        (_firstNameController.text != "" &&
                _secondNameController.text != "" &&
                _firstSurnameController.text != "" &&
                _secondSurnameController.text != "" ||
            _nameController.text != "")) {
      Nit newNit = new Nit();
      Nit savedNit;
      newNit.cEmp = "1";
      newNit.aa = _aaController.text;
      newNit.dirElect = _emailController.text;
      newNit.tel = _phoneController.text;
      newNit.nom1 = _firstNameController.text;
      newNit.nom2 = _secondNameController.text;
      newNit.ape1 = _firstSurnameController.text;
      newNit.ape2 = _secondSurnameController.text;
      newNit.nom = _nameController.text ?? " ";
      newNit.dir = _addressController.text;
      newNit.nIde = _userIDController.text;
      newNit.dig = _verificationDigitController.text;
      newNit.aa = _aaController.text;
      newNit.fax = _faxController.text;
      newNit.tlx = _telexController.text;
      newNit.ide = _selectedOption;
      newNit.fecha = DateTime.now();
      if (appState.getId == null) {
        savedNit = await saveNit(newNit);
      } else {
        savedNit = await updateNit(appState.getId, newNit);
      }
      if (savedNit != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Nits'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Almacenado ' + savedNit.nIde),
                      SizedBox(height: 10),
                      Text('El proceso ha sido exitoso'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('ENTENDIDO'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))));
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Nits'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Campos Vacíos'),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('ENTENDIDO'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))));
        },
      );
    }
  }
}
