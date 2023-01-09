import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
 final formKey = GlobalKey<FormState>();
  var nameController ;
  var serviceController ;
  var designationController ;
  
  startauthentication() {
    
    final validity = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      formKey.currentState!.save();
      addtasktofirebase();
    }
  }
  addtasktofirebase() async {
    
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc("details")
        .collection("All")
        .doc(DateTime.now().toString())
        .set({
      'Name': nameController,
      'Service Year': serviceController,
      'Designation':designationController
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
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    child: TextFormField(
                      onSaved: (newValue) {
                        nameController = newValue!;
                      },
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Name cannot be empty";
                        }
                        },
                     
                      decoration: const InputDecoration(
                          labelText: 'Enter Employee Name',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextFormField(
                      onSaved: (newValue) {
                        designationController = newValue!;
                      },
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Designation cannot be empty";
                        }
                      },
                 
                      decoration: const InputDecoration(
                          labelText: 'Enter Designation',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    child: TextFormField(
                      onSaved: (newValue) {
                        serviceController = newValue!;
                      },
                      validator: (value) {
                        if(value!.isEmpty ){
                          return "Enter a valid number";
                        }
                      },
                      keyboardType:TextInputType.number ,
               
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
                          startauthentication();
                         
                        },
                      ),),
                ],
              ),
            )),
      ),
    );
  }
}
