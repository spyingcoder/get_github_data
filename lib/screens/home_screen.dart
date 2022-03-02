import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    double formWidth = dWidth * 0.65;
    double formHeight = dHeight * 0.09;

    return Scaffold(
      body: Center(
        child: Container(
          height: dHeight * 0.45,
          width: dWidth * 0.80,
          decoration: BoxDecoration(
            color: Colors.blue[900],
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //
              Padding(
                padding: EdgeInsets.only(
                  top: dHeight * 0.03,
                ),
                child: Text(
                  'GitHub Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: dHeight * 0.02,
                  ),
                ),
              ),
              //
              Container(
                margin: EdgeInsets.only(
                  top: dHeight * 0.05,
                  bottom: dHeight * 0.02,
                ),
                padding: EdgeInsets.only(top: dHeight * 0.01),
                height: formHeight,
                width: formWidth,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: dHeight * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your GitHub Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              //
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text("Your GitHub Details:"),
                          // content: RichText(
                          //
                          // ),
                          actions: [],
                        );
                      });
                },
                child: Text("Get Data"),
              ),
              //
              //
            ],
          ),
        ),
      ),
    );
  }
}
