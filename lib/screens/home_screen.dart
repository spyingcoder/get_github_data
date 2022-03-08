import 'package:flutter/material.dart';

import '../album.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //VALIDATION KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //
  //FORM VALIDATION FUNCTION ------------------------------------------------->>
  void validation() {
    FormState _form = _formKey.currentState;
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
  }

  Future<Album> futureAlbum;

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
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.blue[900],
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
                        return "Please Enter Your Username!";
                      }
                      return "";
                    },
                    style: TextStyle(
                      fontSize: dHeight * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      enabled: true,
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
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.white)),
                  ),
                  onPressed: () {
                    // print("object");
                    setState(() {
                      Username.username = controller.text;
                    });
                    futureAlbum = fetchAlbum();
                    validation();
                    print(_formKey.currentState.validate());
                    // print
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            //
                            //GET DATA FROM THIS LINK - "https://api.github.com/users/spyingcoder"
                            //
                            scrollable: true,
                            title: Text("Your GitHub Details:"),
                            content: FutureBuilder<Album>(
                              future: futureAlbum,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Username: "),
                                              Text(snapshot.data.login),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Id: "),
                                              Text("${snapshot.data.id}"),
                                            ],
                                          ),
                                         Row(
                                              children: [
                                                Text("Node Id: "),
                                                Text(snapshot.data.nodeId),
                                              ],
                                            ),
                                          Row(
                                            children: [
                                              Text("Followers: "),
                                              Text(
                                                  "${snapshot.data.followers}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Following: "),
                                              Text(
                                                  "${snapshot.data.following}"),
                                            ],
                                          ),
                                          // Text("Username: "),
                                          // Text(snapshot.data.login),
                                        ],
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            //Text(
                            //    controller.text

                            // RichText(
                            //
                            // ),
                            //),
                            actions: <Widget>[],
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
