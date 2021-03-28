import 'package:editable/editable.dart';
import 'package:flutter/material.dart';


class TablePage extends StatefulWidget {
 @override
 _TablePageState createState() => _TablePageState();
}
class _TablePageState extends State<TablePage> {
  final _editableKey = GlobalKey<EditableState>();
  void _addNewRow() {
    setState(() {
      _editableKey.currentState.createRow();
    });
  }
  
@override
 Widget build(BuildContext context) {
   const PrimaryColor = const Color(0xFF151026);
   List rows = [
   {"Word": 'Essien Ikpa', "Definition":'this is the name',"Level":'2'}, 
 ];
//Headers or Columns
List headers = [
   {"title":'Word', 'index': 1, 'key':'Word'},
   {"title":'Definition', 'index': 2, 'key':'Definition'},
   {"title":'Level', 'index': 3, 'key':'Level'},
 ];
 return Scaffold(
   
    appBar: AppBar(
      title: Text('Vocab list', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.blue,
      ),
    body: Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      constraints: BoxConstraints.expand(),
      color: Colors.white,
      child: Editable(
      key: _editableKey,
      columns: headers, 
      rows: rows,
      
      // showCreateButton: true,
      tdStyle: TextStyle(fontSize: 20),
      // showSaveIcon: true,
      saveIcon : Icons.save,
      borderColor: Colors.grey.shade300,
      onSubmitted: (value){ //new line
        print(value); //you can grab this data to store anywhere
      },
      onRowSaved: (value){ //added line
        print(value); //prints to console
      },
    ),
    
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blue,
      child: Icon(Icons.add),
      onPressed: _addNewRow,
    ),
    );
  }
}
