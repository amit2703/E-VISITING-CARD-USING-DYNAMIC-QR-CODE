import 'package:flutter/material.dart';
import 'package:barcode_scanner/scan.dart';
import 'package:barcode_scanner/generate.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Image.asset('images/card.png',
                width: 10, height: 300, 
                fit: BoxFit.fill),
          ),
// getImageAsset(),
//Image(image: AssetImage('images/gov.png')),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 120.0),
            child: RaisedButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanScreen()),
                );
              },
              child: const Text('SCAN'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 120.0),
            child: RaisedButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerateScreen()),
                  );
                },
                child: const Text('GENERATE')),
          ),
        ],
      )),
    );
  }
}
