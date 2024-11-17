import 'package:flutter/material.dart';
import 'package:flutter_hive/Boxes/box_page.dart';
import 'package:flutter_hive/model/notes_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Hive DataBase',
            style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          )),
          backgroundColor: Colors.green,
        ),
        body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: BoxPage.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
              itemCount: box.length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return Card(
                    color: Colors.red,
                    margin: const EdgeInsets.all(10),
                    elevation: 5,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                data[index].title.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                data[index].directory.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  // update_showMyDialog(data[index], data[index].title.toString(), data[index].description.toString());
                                  updateShowDialog(data[index], data[index].title.toString(),data[index].directory.toString());
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deletes(data[index]);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  );
                }
                else if (index >= 7) {
                  return Card(
                    color: Colors.blue,
                    margin: const EdgeInsets.all(10),
                    elevation: 5,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                data[index].title.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                data[index].directory.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  // update_showMyDialog(data[index], data[index].title.toString(), data[index].description.toString());
                                  updateShowDialog(data[index], data[index].title.toString(),data[index].directory.toString());
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deletes(data[index]);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  );
                }
                else {
                  return Card(
                    color: Colors.green,
                    margin: const EdgeInsets.all(10),
                    elevation: 5,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                data[index].title.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                data[index].directory.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  updateShowDialog(data[index], data[index].title.toString(),data[index].directory.toString());
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deletes(data[index]);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50, right: 20),
          child: FloatingActionButton(
            elevation: 10,
            onPressed: () async {
              // var box = await Hive.openBox('BoxName');
              // box.put('name', 'Niraj kumar');
              // print(box.get('name'));
              _showDialog_insert();
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  //insert Data
  Future<void> _showDialog_insert() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: const Text('Add Notes')),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Description'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18),
                )),
            const SizedBox(
              width: 130,
            ),
            TextButton(
                onPressed: () {
                  final data = NotesModel(
                      title: titleController.text,
                      directory: descriptionController.text);
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    final box = BoxPage.getData();
                    box.add(data);
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(
                        msg: 'please fill in the blanks',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.greenAccent,
                        fontSize: 18);
                  }
                  titleController.clear();
                  descriptionController.clear();
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ],
        );
      },
    );
  }

  //delete date
  void deletes(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> updateShowDialog(NotesModel notesModel, String title, String description) async {
    titleController.text =title;
    descriptionController.text = description;
    return showDialog(
      barrierDismissible: false,
      context: context, builder: (context) {
        return SizedBox(
          height: 250,
          width: 450,
          child: AlertDialog(
            title:Center(child:  Text('Update Notes')),
            content: SingleChildScrollView(
              child:Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Title',
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Description'),
                    ),
                  ]
              ) ,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 100,
              ),
              TextButton(
                  onPressed: () {
                    notesModel.title = titleController.text.toString();
                    notesModel.directory =
                        descriptionController.text.toString();
                    notesModel.save();
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();
                  },
                  child: const Text('Update', style: TextStyle(fontSize: 18))),
            ],
          ),
        );

    },);
  }
}
