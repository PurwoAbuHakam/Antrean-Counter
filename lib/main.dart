import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMP Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'LMP Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController resetValue = TextEditingController();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void validateAndReset(BuildContext context) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        _counter = int.parse(resetValue.text);
      });
      resetValue.clear();
      Navigator.of(context).pop(false);
      // _resetCounter();
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nomor Antrian :', style: TextStyle(fontSize: 20.0)),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 150.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green)),
                  color: Colors.white,
                  textColor: Colors.black,
                  padding: EdgeInsets.all(20.0),
                  onPressed: () {
                    // setState(() {
                    //   _resetCounter();
                    // });
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Reset Start From ?',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    height: 20,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      controller: resetValue,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Reset value'),
                                      validator: (value) => value.isEmpty
                                          ? 'value cannot be empty'
                                          : null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40.0),
                                    child: Row(
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 40.0),
                                        ),
                                        RaisedButton(
                                          color: Colors.green,
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0),
                                          ),
                                          onPressed: () {
                                            validateAndReset(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    "RESET",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green)),
                  color: Colors.green,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  onPressed: () {
                    setState(() {
                      _incrementCounter();
                    });
                  },
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
