import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tdms/data/models/box_model.dart';
import 'package:tdms/data/remote_data_source/firestore_helper.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: ModifyPage(),
    ),
  );
}

class ModifyPage extends StatelessWidget {
  ModifyPage({super.key});

  TextEditingController _caseIDController = TextEditingController();
  TextEditingController _boxIDController = TextEditingController();
  TextEditingController _contentsController = TextEditingController();
  TextEditingController _validatorController = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Add a Box'), backgroundColor: Colors.red[800]),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _caseIDController,
                decoration: const InputDecoration(
                  labelText: "Case ID",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 198, 40, 40), width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _boxIDController,
                decoration: const InputDecoration(
                  labelText: "Box ID",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 198, 40, 40), width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _contentsController,
                decoration: const InputDecoration(
                  labelText: "Box Contents",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 198, 40, 40), width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _validatorController,
                decoration: const InputDecoration(
                  labelText: "Validator",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 198, 40, 40), width: 2.0),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 198, 40, 40)),
                  ),
                  onPressed: () {
                    FirestoreHelper.create(
                      BoxModel(
                          boxID: _boxIDController.text,
                          caseID: _caseIDController.text,
                          contents: _contentsController.text,
                          vname: _validatorController.text),
                    ).then((value) {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    });
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ],
        ));
  }
}
