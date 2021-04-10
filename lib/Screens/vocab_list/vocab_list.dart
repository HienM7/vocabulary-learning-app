import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// NewCoursePage
class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  checkAuthentification() async {
    auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  final _editableKey = GlobalKey<EditableState>();
   List listOfColumns = [
    {"word": "civilization(n)", "meaning": "nền văn minh", "level": "1"},
    {"word": "virtual(adj)", "meaning": "ảo", "level": "3"},
    {"word": "independence(n)", "meaning": "sự độc lập", "level": "5"},
    {"word": "Indian(n)", "meaning": "Người Ấn Độ", "level": "5"},
    {}
  ];

  @override
  Widget build(BuildContext context) {
    const PrimaryColor = const Color(0xFF151026);
    List rows = [
      {"Word": 'Essien Ikpa', "Definition": 'this is the name', "Level": '2'},
    ];
    //Headers or Columns
    List headers = [
      {"title": 'Word', 'index': 1, 'key': 'Word'},
      {"title": 'Definition', 'index': 2, 'key': 'Definition'},
      {"title": 'Level', 'index': 3, 'key': 'Level'},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocab list', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
          // scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Center(
                child: Text(
                  'Word List',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold))
              ),
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: addNewRow,
                iconSize: 30,
                // alignment: Alignment.topLeft,
              ),
            ),

          SingleChildScrollView(
            child: DataTable(
            sortColumnIndex: 0,
            sortAscending: true,
            columns: [
              
              DataColumn(
                  label: Text('Word',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Meaning',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ))),
              DataColumn(
                  label: Text('Level',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Edit',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Delete',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
            ],
            rows: listOfColumns
                .map(((element) => DataRow(cells: <DataCell>[
                      DataCell(
                        TextFormField(
                          initialValue: element['meaning'] ?? "",
                          keyboardType: TextInputType.text,
                        ),
                        showEditIcon: true,
                      ),
                      DataCell(Text(element['level'] ?? "")),
                      DataCell(
                        TextButton(
                          onPressed: () {},  // onPressed: onCreateCourse,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white)),
                          ),
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      DataCell(
                        TextButton(
                          onPressed: () { xoa(element); },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white)),
                          ),
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ])))
                .toList(),
          ),
        ),
         Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},  // onPressed: onCreateCourse,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(0))
                  ),
                  child: Text(
                    "Create",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  void xoa(Object x) async {
    setState(() {
      listOfColumns.remove(x);
    });
  }

  void addNewRow() {
    setState(() {
      listOfColumns.add({});
    });
  }

  void sua(Object x, Object y) {}
  void read() async {}
}
