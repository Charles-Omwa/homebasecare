import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lifeshare/utils/customWaveIndicator.dart';

class OffersPageView extends StatefulWidget {
  @override
  _OffersPageViewState createState() => _OffersPageViewState();
}

class _OffersPageViewState extends State<OffersPageView> {



  String getShortName(author) {
    String shortName = "";
    if (!author.name.isEmpty) {
      shortName = author.name.substring(0, 1);
    }
    return shortName;
  }
  void customlaunch(command)async {
    if (await canLaunch(command)) {
      await launch(command);
    }else{
      print("could not launch ");
    }
  }
  List<String> content = [];
  List<String> name = [];
  List<String>author = [];
  Widget _child;

  @override
  void initState() {
    _child = WaveIndicator();
    getDonors();
    super.initState();
  }

  Future<Null> getDonors() async {
    await Firestore.instance
        .collection('Offer Details')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          name.add(docs.documents[i].data['name']);
          author.add(docs.documents[i].data['author']);
          content.add(docs.documents[i].data['content']);
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
          "Offers",
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
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(

                  child: Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
//                          CircleAvatar(
//                            radius: 30.0,
////                            child: new Text(getShortName(author)),
//                            backgroundColor: Colors.black.withOpacity(0.7),
//                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text('Author  :' + author[index],style: new TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 20.0, color: Colors.black),),
                                  SizedBox(height: 15,),
                                  Text('Organisation :' +name[index] ,style: new TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 20.0, color: Colors.black),),
                                  SizedBox(height: 15,),
                                  Text(content[index],style: new TextStyle(
                                      fontSize: 15.0, color: Colors.black),),
                                ],
                              ),
                            ),
                          ),
                          Align(

                          ),
                        ],
                      ),
                    ),
                  ),


color: Colors.deepPurple
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
