import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lifeshare/utils/customWaveIndicator.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void customlaunch(command)async {
    if (await canLaunch(command)) {
      await launch(command);
    }else{
      print("could not launch ");
    }
  }
  List<String> nurses = [];
  List<String> profession = [];
  List<String> phone = [];
  List<String> speciality = [];
  Widget _child;

  @override
  void initState() {
    _child = WaveIndicator();
    getDonors();
    super.initState();
  }

  Future<Null> getDonors() async {
    await Firestore.instance
        .collection('User Details')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          nurses.add(docs.documents[i].data['name']);
          profession.add(docs.documents[i].data['profession']);
          phone.add(docs.documents[i].data['phone']);
          speciality.add(docs.documents[i].data['speciality']);
        }
      }
    });
    setState(() {
      _child = myWidget();
    });
  }

  Widget myWidget() {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Services",
          style: TextStyle(
            fontSize: 50.0,
            fontFamily: "SouthernAire",
            color: Colors.white,
          ),
        ),
         leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.reply,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: nurses.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            child: Text(
                              profession[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.deepPurple,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(nurses[index]),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(speciality[index]),
                          SizedBox(height: 10,),
                          Text(phone[index]),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.message),
                                  onPressed: () {

                                    customlaunch("sms:"+ phone[index]);
                                  },
                                  color: Colors.deepPurple,
                                ),
                                IconButton(
                                  icon: Icon(Icons.phone),
                                  onPressed: () {
                                    customlaunch("tel:"+ phone[index]);
                                  },
                                  color: Colors.deepPurple,
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),


                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
