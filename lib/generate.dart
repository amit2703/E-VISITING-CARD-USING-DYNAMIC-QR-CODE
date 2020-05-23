import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  String _gender;
  final TextEditingController _textControllerName = TextEditingController();
  final TextEditingController _textControllerAge = TextEditingController();
  final TextEditingController _textControllerDob = TextEditingController();
  final TextEditingController _textControllerAddress = TextEditingController();
  final TextEditingController _textControllerMobile = TextEditingController();
  final TextEditingController _textControllerCompany = TextEditingController();
  final TextEditingController _textControllerWebsite = TextEditingController();
  final TextEditingController _textControllerLinkedIn = TextEditingController();
  final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerFacebook = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.camellabs.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
        color: const Color(0xFFFFFFFF),
        child: ListView(
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _textControllerName,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Name',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  GenderSelector(
                    margin: EdgeInsets.all(5.0
                    ),
                    selectedGender: Gender.NONE,
                    onChanged: (gender) async {
                      if (gender == Gender.FEMALE) {
                          _gender = "Female";
                        }
                        if (gender == Gender.MALE) {
                          _gender = "Male";
                        }
                    },
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _textControllerAge,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Age',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.confirmation_number),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: _textControllerDob,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'DOB',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: _textControllerAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Address',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.place),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _textControllerMobile,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Mobile No.',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.phone),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _textControllerCompany,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Company',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.work),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      controller: _textControllerWebsite,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Your Website',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.web_asset),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      controller: _textControllerLinkedIn,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'LinkedIn Profile',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.web_asset),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _textControllerEmail,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Email Id',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      controller: _textControllerFacebook,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Facebook Profile',
                        errorText: _inputErrorText,
                        prefixIcon: Icon(Icons.person_outline),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,

                      child: Text("SUBMIT"),
                      onPressed: () {
                        setState(() {
                          _dataString = "Name: " + _textControllerName.text +"\n" +
                                        "Gender: "+_gender + "\n" +
                                        "Age: " + _textControllerAge.text +"\n" +
                                        "DOB: " + _textControllerDob.text +"\n" +
                                        "Address: " +_textControllerAddress.text +"\n"+
                                        "Mobile No: " +_textControllerMobile.text +"\n"+
                                        "Company: " + _textControllerCompany.text + "\n"+
                                        "My Website: " + _textControllerWebsite.text + "\n"+
                                        "LinkedIn Profile: " + _textControllerLinkedIn.text + "\n" +
                                        "Email Id: " + _textControllerEmail.text + "\n" +
                                        "Facebook Profile: " + _textControllerFacebook.text + "\n";
                          _inputErrorText = null;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Center(
                      child: RepaintBoundary(
                        key: globalKey,
                        child: QrImage(
                          data: _dataString,
                          size: 0.25 * bodyHeight,
                        ),
                      ),
                    ),
                  ),
                ]),
          ],
        ));
  }
}
