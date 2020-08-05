import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:lifeshare/utils/customWaveIndicator.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void customlaunch(command)async {
    if (await canLaunch(command)) {
      await launch(command);
    }else{
      print("could not launch ");
    }
  }
  String mobile;
  List<String> request = [];
  List<String> profession = [];
  List<String> speciality = [];
  List<String> address = [];
  List<String> name = [];

  Widget _child;

  @override
  void initState() {
    _child = WaveIndicator();
    getDonors();
    super.initState();
  }

  Future<Null> getDonors() async {
    await Firestore.instance
        .collection('Service Details')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          request.add(docs.documents[i].data['phone']);
          profession.add(docs.documents[i].data['profession']);
          name.add(docs.documents[i].data['name']);
          address.add(docs.documents[i].data['address']);
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
          "Available Medics",
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
          color: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: request.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Card(
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
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[


                                   Text('name:'  + name[index]),
                                    SizedBox(height: 10),
                                    Text(request[index]),
                                    SizedBox(height: 10),
                                    Text('speciality :'  +    speciality[index]),
                                    SizedBox(height: 10),
                                    Text('Address:'+ ' '+ address[index])
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.message),
                                    onPressed: () {

                                      customlaunch("sms:"+ request[index]);
                                    },
                                    color: Colors.deepPurple,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: () {
                                     customlaunch("tel:"+ request[index]);
                                      //FlutterOpenWhatsapp.sendSingleMessage('0723874532', "Hello");
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
