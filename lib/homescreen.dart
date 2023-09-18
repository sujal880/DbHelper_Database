import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:notes_database_wslc_147/dbhelper.dart';
import 'package:notes_database_wslc_147/uihelper.dart';

import 'notesmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  late DbHelper mydb;
  List<NotesModel>arrNotes=[];

  final color=[
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.black,
    Colors.yellow,
    Colors.amber,
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.black,
    Colors.yellow,
    Colors.amber,
    Colors.purple,
  ];

  final heights=[
    100,
    200,
    140,
    170,
    190,
    100,
    200,
    140,
    170,
    190,

  ];
  @override
  void initState() {
    super.initState();
    mydb=DbHelper.db;
    getNotes();
  }

  void getNotes()async{
    arrNotes=await mydb.fetchNotes();
    setState(() {

    });
  }

  void addNotes(String title,String desc)async{
    bool check=await mydb.addNotes(NotesModel(title: title, description: desc));
    if(check){
      arrNotes=await mydb.fetchNotes();
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        centerTitle: true,
      ),
      body: DynamicHeightGridView(builder: (ctx,index){
        color.shuffle();
        heights.shuffle();
        return Container(
          height: heights.first.toDouble(),
          color: color.first,
          child: ListTile(
            leading: CircleAvatar(
              child: Text("${arrNotes[index].noteid.toString()}"),
            ),
            title: Text("${arrNotes[index].title.toString()}"),
            subtitle: Text("${arrNotes[index].description.toString()}"),
          ),
        );
      }, itemCount: arrNotes.length, crossAxisCount: 3),
      // body: ListView.builder(itemBuilder: (context,index){
      //   return ListTile(
      //     leading: CircleAvatar(
      //       child: Text("${arrNotes[index].noteid.toString()}"),
      //     ),
      //     title: Text("${arrNotes[index].title.toString()}"),
      //     subtitle: Text("${arrNotes[index].description.toString()}"),
      //     trailing: Icon(Icons.delete),
      //   );
      // },itemCount: arrNotes.length,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _bottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            width: 320,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiHelper.CustomTextField(
                    titleController, "Add Title", Icons.title),
                UiHelper.CustomTextField(
                    descController, "Add Description", Icons.description),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 330,
                  child: ElevatedButton(
                      onPressed: () {
                        addNotes(titleController.text.toString(), descController.text.toString());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text("Add Data")),
                )
              ],
            ),
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27), topRight: Radius.circular(27))));
  }
}
