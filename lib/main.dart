import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud_app/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.amber[500],
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ====================================================== //
  String namaMahasiswa, nim, prodi;
  double ipk;

  getNamaMahasiswa(name) {
    this.namaMahasiswa = name;
  }

  getNim(id) {
    this.nim = id;
  }

  getProdi(pid) {
    this.prodi = pid;
  }

  getIPK(result) {
    this.ipk = double.parse(result);
  }

  TextEditingController _nmMahasiswaCtrl = TextEditingController();
  TextEditingController _nimCtrl = TextEditingController();
  TextEditingController _prodiCtrl = TextEditingController();
  TextEditingController _ipkCtrl = TextEditingController();

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('mahasiswa').doc(namaMahasiswa);

    Map<String, dynamic> mahasiswa = ({
      "namaMahasiswa": namaMahasiswa,
      "nim": nim,
      "prodi": prodi,
      "ipk": ipk
    });

    // send data to Firebase
    documentReference
        .set(mahasiswa)
        .whenComplete(() => print('$namaMahasiswa created')); 
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('mahasiswa').doc(namaMahasiswa);

    documentReference.get().then((dataSnapshot) {
      print(dataSnapshot.data()["namaMahasiwa"]);
      print(dataSnapshot.data()["nim"]);
      print(dataSnapshot.data()["prodi"]);
      print(dataSnapshot.data()["ipk"]);
    });
  }

  edit(namaMahasiswa) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('mahasiswa').doc(namaMahasiswa);

    documentReference.get().then((dataSnapshot) {
      print(dataSnapshot.data()["namaMahasiswa"]);
      print(dataSnapshot.data()["nim"]);
      print(dataSnapshot.data()["prodi"]);
      print(dataSnapshot.data()["ipk"]);

      setState(() {
      _nmMahasiswaCtrl.text = dataSnapshot.data()['namaMahasiswa'];
      _nimCtrl.text= dataSnapshot.data()['nim'];
      _prodiCtrl.text = dataSnapshot.data()['prodi'];
      _ipkCtrl.text = dataSnapshot.data()['ipk'].toString();   

      namaMahasiswa = dataSnapshot.data()['namaMahasiswa'];
      nim = dataSnapshot.data()['nim'];
      prodi = dataSnapshot.data()['prodi'];
      ipk = dataSnapshot.data()['ipk'];
      });

     print("INSIDE");
      print(namaMahasiswa);
      print(nim);
      print(prodi);
      print(ipk);
     
    });
  }

  updateData() {
    // print(namaMahasiswa);
      print(nim);
      print(prodi);
      print(ipk);

      String namaMahasiswa = _nmMahasiswaCtrl.text;

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('mahasiswa').doc(namaMahasiswa);

    Map<String, dynamic> mahasiswa = ({
      "namaMahasiswa": namaMahasiswa,
      "nim": nim,
      "prodi": prodi,
      "ipk": ipk
    });

    documentReference
        .update(mahasiswa)
        .whenComplete(() => print('$namaMahasiswa updated'));
  }

  deleteData(namaMahasiswa) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('mahasiswa').doc(namaMahasiswa);

    documentReference
        .delete()
        .whenComplete(() => print('$namaMahasiswa deleted'));
  }
  // ====================================================== //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD App Data Mahasiswa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nmMahasiswaCtrl,
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'Nama Mahasiswa',
                  Icon(Icons.account_circle_outlined),
                ),
                onChanged: (String name){
                  setState(() {
                    
                    getNamaMahasiswa(name);
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _nimCtrl,
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'NIM',
                  Icon(Icons.perm_identity_outlined),
                ),
                onChanged: (String nim){
                  setState(() {
                    getNim(nim);
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _prodiCtrl,
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'Prodi',
                  Icon(Icons.perm_identity_outlined),
                ),
            onChanged: (String prodi){
                  setState(() {
                    getProdi(prodi);
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _ipkCtrl,
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'IPK',
                  Icon(Icons.confirmation_number_outlined),
                ),
              onChanged: (String ipk){
                  setState(() {
                    getIPK(ipk);
                  });
                },
              ),
              SizedBox(height: 15.0),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                
                      style: ElevatedButton.styleFrom(
                        
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 8.0,
                        primary: Colors.green,
                        shape: raisedButtonBorder(),
                      ),
                      onPressed: () => createData(),
                      child: Text('Simpan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                ElevatedButton(
                
                      style: ElevatedButton.styleFrom(
                        
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 8.0,
                        primary: Colors.blue,
                        shape: raisedButtonBorder(),
                      ),
                      onPressed: () => updateData(),
                      child: Text('Perbaharui',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                   ElevatedButton(
                
                      style: ElevatedButton.styleFrom(
                        
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 8.0,
                        primary: Colors.indigo,
                        shape: raisedButtonBorder(),
                      ),
                      onPressed: ()  {
                         _nmMahasiswaCtrl.text = "";
      _nimCtrl.text = "";
      _prodiCtrl.text = "";
      _ipkCtrl.text = "";

       namaMahasiswa = "";
      nim = "";
      prodi = "";
      ipk = null;
                      },
                      child: Text('Clear',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                ],
              ),

              Divider(thickness: 1.0, height: 25.0, color: Colors.green),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Nama',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'NIM',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Prodi',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'IPK',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Action',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('mahasiswa').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                documentSnapshot["namaMahasiswa"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot["nim"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot["prodi"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot["ipk"].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.all(0.0),
                                    icon: Icon(Icons.edit),
                                    color: Colors.blue,
                                    onPressed: (){
                                      edit(documentSnapshot["namaMahasiswa"]);
                                    }
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.all(0.0),
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,

                                    onPressed: (){
                                      deleteData(documentSnapshot["namaMahasiswa"]);
                                    }
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
