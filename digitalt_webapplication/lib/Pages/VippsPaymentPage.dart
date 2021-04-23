import 'package:digitalt_application/LoginRegister/Views/loginView.dart';
import 'package:digitalt_application/Pages/SubscriptionPage.dart';
import 'package:digitalt_application/Services/VippsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VippsPaymentPage extends StatefulWidget {
  @override
  _VippsPaymentPageState createState() => _VippsPaymentPageState();
}

class _VippsPaymentPageState extends State<VippsPaymentPage> {
  final VippsApi _vippsApi = VippsApi();
  final number = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAccessToken();
  }

  _getAccessToken() {
    _vippsApi.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.grey.shade100,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 400,
            height: 400,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: Column(children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 50,
                  child: Image(
                    image: AssetImage('vipps/vippsLogo.png'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Betal',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text('1029 kr til DIGI-TALT.NO AS',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    controller: number,

                    decoration: new InputDecoration(labelText: "Telefonnummer"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 75,
                  child: ElevatedButton(
                      child: Text("Neste".toUpperCase(),
                          style: TextStyle(fontSize: 10)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepOrange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {
                        //VippsApi().getAccessToken();
                      }),
                )
              ]),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscriptionPage()));
              },
              child: Text(
                'Avbryt',
                style: TextStyle(color: Colors.grey),
              ))
        ],
      )),
    ));
  }
}
