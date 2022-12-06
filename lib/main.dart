import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_details/add_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("List of employees"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("tasks")
              .doc("details")
              .collection("All")
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  
                  String yes = docs[index]["Service Year"];
                  final double ok = double.parse(yes);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      
                      color: Colors.lightBlue.shade100.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                        trailing: IconButton(
                            color: ok > 5 ? Colors.green : Colors.transparent,
                            icon: const Icon(
                              Icons.bookmark,
                            ),
                            onPressed: () {}),
                        title: Text(
                          "Employee Name : ${docs[index]["Name"]}",
                          
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Designation : ${docs[index]["Designation"]}",
                            style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Duration of employment : ${docs[index]["Service Year"]} Years",
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddData()));
          },
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}
