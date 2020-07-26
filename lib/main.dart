import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedPositive Contact Us',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Gilroy',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name;
  String emailId;
  String phone;
  bool _loader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, spreadRadius: 2, color: Colors.black12)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    //height: 52,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black54, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black87, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    //height: 52,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          emailId = val;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Your Email',
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black54, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black87, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    //height: 52,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          phone = val;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Your Phone Number',
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black54, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black87, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                      ),
                    ),
                  ),
                  (_loader)
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : Builder(
                          builder: (ctx) => RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              color: Colors.redAccent,
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                if (name == null ||
                                    emailId == null ||
                                    phone == null) {
                                  Scaffold.of(ctx).showSnackBar(SnackBar(
                                      content: Text('Please Fill The Data')));
                                } else {
                                  setState(() {
                                    _loader = true;
                                  });
                                  Email email = Email(
                                    body:
                                        'Name : $name \n Email : $emailId \n Phone : $phone\n',
                                    subject: 'Contacted from $name',
                                    recipients: ['info@redpositive.in'],
                                    isHTML: false,
                                  );

                                  try {
                                    await FlutterEmailSender.send(email)
                                        .whenComplete(() {
                                      setState(() {
                                        _loader = false;
                                      });
                                      Scaffold.of(ctx).showSnackBar(SnackBar(
                                          content: Text(
                                              'Thank you for contacting us')));
                                    });
                                  } catch (e) {
                                    setState(() {
                                      _loader = false;
                                    });
                                    Scaffold.of(ctx).showSnackBar(
                                        SnackBar(content: Text(e.message)));
                                  }
                                }
                              }),
                        )
                ]),
          ),
        ),
      ),
    );
  }
}
