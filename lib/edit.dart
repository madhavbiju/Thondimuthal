import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tdms/data/models/box_model.dart';
import 'package:tdms/data/remote_data_source/firestore_helper.dart';
import 'package:tdms/modify.dart';
import 'package:tdms/home.dart';

class EditPage extends StatefulWidget {
  final BoxModel user;
  const EditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController? _boxIDController;
  TextEditingController? _contentsController;
  TextEditingController? _caseIDController;
  TextEditingController? _validatorController;

  @override
  void initState() {
    _boxIDController = TextEditingController(text: widget.user.boxID);
    _contentsController = TextEditingController(text: widget.user.contents);
    _caseIDController = TextEditingController(text: widget.user.caseID);
    _validatorController = TextEditingController(text: widget.user.vname);

    super.initState();
  }

  @override
  void dispose() {
    _boxIDController!.dispose();
    _contentsController!.dispose();
    _validatorController!.dispose();
    _caseIDController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
          backgroundColor: Colors.red[800],
        ),
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
                    FirestoreHelper.update(
                      BoxModel(
                          boxID: _boxIDController!.text,
                          caseID: _caseIDController!.text,
                          contents: _contentsController!.text,
                          vname: _validatorController!.text),
                    ).then((value) {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    });
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ));
  }
}
