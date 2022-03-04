import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
     this.userId,
     this.id,
     this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Album> futureAlbum;


  //VALIDATION KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //

  //
  //FORM VALIDATION FUNCTION ------------------------------------------------->>
  void validation() {
    final FormState _form = _formKey.currentState;
    if (_form.validate()) {
      print("Yes");
    } else {
      print("No");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = fetchAlbum();
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    double formWidth = dWidth * 0.65;
    double formHeight = dHeight * 0.1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            height: dHeight * 0.45,
            width: dWidth * 0.80,
            decoration: BoxDecoration(
              // color: Colors.blue[900],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.white),
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
                    controller: controller,
                    validator: (value) {
                      if (value == "") {
                        return "Please Enter Your Username";
                      }
                      return "";
                    },
                    style: TextStyle(
                      fontSize: dHeight * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      label: Text('Enter the Username'),
                      hintText: 'Enter your GitHub Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
                //
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: Colors.white)
                    ),
                  ),
                  onPressed: () {
                    // print("object");
                    validation();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return  AlertDialog(
                              //
                              //GET DATA FROM THIS LINK - "https://api.github.com/users/spyingcoder"
                              //
                              scrollable: true,
                              title: Text("Your GitHub Details:"),
                              content:
                              Center(
                                child: FutureBuilder<Album>(
                                  future: futureAlbum,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data.title);
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }

                                    // By default, show a loading spinner.
                                    return const CircularProgressIndicator();
                                  },
                                ),
                              ),
                              // Text(controller.text.toString()),
                              // content: RichText(
                              //
                              // ),
                              actions: <Widget>[
                              ],
                            );
                          });
                  },
                  child: const Text("Get Data"),
                ),
                //

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
