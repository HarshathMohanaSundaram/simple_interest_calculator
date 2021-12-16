import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Simple Interest Calculator",
        home: SIForm(),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
        ),
      ),
    );

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIState();
  }
}

class SIState extends State<SIForm> {
  var formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pound'];
  final _minimumPadding = 5.0;
  var currentItemSelected = "Rupees";
  var display = "";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: formkey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textstyle,
                      controller: principalController,
                      validator: (value) {
                        if ((value!.isEmpty) )
                          return "Please Enter the Principal Amount";
                        else if(value is String)
                          return "It contains only number!";
                      },
                      decoration: InputDecoration(
                        labelText: "Principal",
                        labelStyle: textstyle,
                        hintText: "Enter Principal Amount Eg:12000",
                        errorStyle: TextStyle(
                          color:Colors.yellowAccent,
                          fontSize:15.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textstyle,
                      controller: roiController,
                      validator: (value) {
                        if ((value!.isEmpty) )
                          return "Please Enter the Rate Of Interest";
                        else if(value is String)
                          return "It contains only number!";
                      },
                      decoration: InputDecoration(
                        labelText: "Rate Of Interest",
                        labelStyle: textstyle,
                        hintText: "In Percentage",
                        errorStyle: TextStyle(
                          color:Colors.yellowAccent,
                          fontSize:15.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textstyle,
                          controller: termController,
                          validator: (value) {
                            if ((value!.isEmpty) )
                              return "Please Enter term years";
                            else if(value is String)
                              return "It contains only number!";
                          },
                          decoration: InputDecoration(
                            labelText: "Term",
                            labelStyle: textstyle,
                            hintText: "Time In Years",
                            errorStyle: TextStyle(
                              color:Colors.yellowAccent,
                              fontSize:15.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          value: currentItemSelected,
                          onChanged: (newValueSelected) {
                            _dropDownUpdated(newValueSelected.toString());
                          },
                        )),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (formkey.currentState!.validate()) {
                                this.display = _calculateTotalPayable();
                              }
                            });
                          },
                        )),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              "Reset",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              reset();
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.display,
                    style: textstyle,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10.0),
    );
  }

  void _dropDownUpdated(String value) {
    setState(() {
      this.currentItemSelected = value;
    });
  }

  String _calculateTotalPayable() {
    double p = double.parse(principalController.text);
    double r = double.parse(roiController.text);
    int t = int.parse(termController.text);
    double total = p + ((p * r * t) / 100);
    String result =
        "After $t years, The Invested amount will be worth of $total $currentItemSelected";
    return result;
  }

  void reset() {
    setState(() {
      principalController.text = "";
      roiController.text = "";
      termController.text = "";
      display = "";
      currentItemSelected = _currencies[0];
    });
  }
}
