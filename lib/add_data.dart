import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
 
  TextEditingController nameController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  addtasktofirebase() async {
    
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc("details")
        .collection("All")
        .doc(DateTime.now().toString())
        .set({
      'Name': nameController.text,
      'Service Year': serviceController.text,
      'Designation':designationController.text
    }).then((value) => Navigator.pop(context));
   
    
    Fluttertoast.showToast(msg: 'New Employee added',backgroundColor: Colors.red);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add employee details"),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: 'Enter Employee Name',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: designationController,
                  decoration: const InputDecoration(
                      labelText: 'Enter Designation',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: TextField(
                  keyboardType:TextInputType.number ,
                  controller: serviceController,
                  decoration: const InputDecoration(
                      labelText: 'Enter Service Years',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                    child: const Text(
                      'Add Data',
                    ),
                    onPressed: () {
                      addtasktofirebase();
                     
                    },
                  ),),
            ],
          )),
    );
  }
}
