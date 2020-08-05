import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
import 'package:lifeshare/utils/customDialogs.dart';
import './home.dart';
import 'medicpage.dart';

class RegisterPage extends StatefulWidget {
  final FirebaseAuth appAuth;
  RegisterPage(this.appAuth);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  String _licence;
  String _phone;
  List<String> _profession = ['N','D'];
  String _selected = '';
  bool _categorySelected = false;
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(_user) async {
    if (isLoggedIn()) {
      Firestore.instance
          .collection('User Details')
          .document(_user['uid'])
          .setData(_user)
          .catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged In');
    }
  }

  bool validate_save() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validate_submit(BuildContext context) async {
    if (validate_save()) {
      try {
        CustomDialogs.progressDialog(
            context: context, message: 'Registration under process');
        FirebaseUser user = (await widget.appAuth
                .createUserWithEmailAndPassword(
                    email: _email.trim(), password: _password))
            .user;
        Navigator.pop(context);
        print('Registered User: ${user.uid}');
        final Map<String, dynamic> UserDetails = {
          'uid': user.uid,
          'name': _name,
          'email': _email,
          'phone': _phone,
          'Licence NO': _licence,
          'profession': _selected,
        };
        addData(UserDetails).then((result) {
          print("User Added");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) =>MedicPage()));
        }).catchError((e) {
          print(e);
        });
      } catch (e) {
        print('Errr : $e');
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Registration Failed'),
                content: Text('Error : $e'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
      systemNavigationBarColor: Colors.black, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Register",
          style: TextStyle(
            fontSize: 60.0,
            fontFamily: "SouthernAire",
            color: Colors.white,
          ),
        ),
      ),
      body: ClipRRect(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0)),
        child: Container(
          height: 800.0,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.deepPurple,
                            ),
                          ),
                          validator: (value) => value.isEmpty
                              ? "Name field can't be empty"
                              : null,
                          onSaved: (value) => _name = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField( keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'phone',

                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.deepPurple,
                            ),
                          ),
                          validator: (value) => value.isEmpty
                              ? "Name field can't be empty"
                              : null,
                          onSaved: (value) => _phone = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Licence Number',
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.deepPurple,
                            ),
                          ),
                          validator: (value) => value.isEmpty
                              ? "Name field can't be empty"
                              : null,
                          onSaved: (value) => _licence = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email ID',
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.deepPurple,
                            ),
                          ),
                          validator: (value) => value.isEmpty
                              ? "Email ID field can't be empty"
                              : null,
                          onSaved: (value) => _email = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            icon: Icon(
                              FontAwesomeIcons.userLock,
                              color: Colors.deepPurple,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) => value.isEmpty
                              ? "Password field can't be empty"
                              : null,
                          onSaved: (value) => _password = value,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 20.0),
                              child: DropdownButton(
                                hint: Text(
                                  'Please choose a Profession',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                iconSize: 40.0,
                                items: _profession.map((val) {
                                  return new DropdownMenuItem<String>(
                                    value: val,
                                    child: new Text(val),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selected = newValue;
                                    this._categorySelected = true;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              _selected,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RaisedButton(
                        onPressed: () => validate_submit(context),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        color: Colors.deepPurple,
                        child: Text("REGISTER"),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
