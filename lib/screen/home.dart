// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../assets/data_model.dart';
import 'add_student_screen.dart';
import 'student_details.dart';
import 'update_screen.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  Icon myIcon = const Icon(Icons.search); //creating a custom icon
  Widget myField = const Text('List Item'); //creating a custom Field
  String searchInput = ''; //search input
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myField,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (myIcon.icon == Icons.search) {
                  myIcon = const Icon(Icons.clear);
                  myField = TextField(
                    onChanged: (value) {
                      setState(() {
                        searchInput =
                            value; //searched values goes to search input
                      });
                    },
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'Search here',
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  );
                } else {
                  setState(() {
                    searchInput = '';
                  });
                  myIcon = const Icon(Icons.search);
                  myField = const Text('List Item');
                }
              });
            },
            // icon: Icon(
            //   Icons.search,
            //   color: Colors.white,
            // ),
            icon: myIcon,
            color: Colors.white,
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<ListItem>('listitems').listenable(),
          builder: (context, Box<ListItem> box, widget) {
            if (box.isEmpty) {
              return const Center(
                child: Text("No data available"),
              );
            }

            final List<ListItem> data = box.values
                .where((element) => element.name!
                    .toLowerCase()
                    .contains(searchInput.toLowerCase()))
                .toList();
            if (data.isEmpty) {
              return Center(
                child: Text("data"),
              );
            }

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  ListItem? obj = box.getAt(index);
                  return Card(
                    child: ListTile(
                      //  leading: Icon(obj!.image),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.green,
                        backgroundImage: FileImage(File("${obj!.image}")),
                      ),
                      title: Text('${obj.name}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateScreen(
                                        ind: index,
                                        name: '${obj.name}',
                                        place: '${obj.place}',
                                        phone: '${obj.phone}',
                                        image: '${obj.image}')),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content:
                                    const Text('Are you sure want to Delete'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      box.deleteAt(index).then(
                                          (value) => print("Item deleted"));
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //ListTile onpressed
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentScreenDetails(
                                  name: '${obj.name}',
                                  place: '${obj.place}',
                                  phone: '${obj.phone}',
                                  image: '${obj.image}')),
                        );
                      },
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStudentScreen()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}

// listScreen(context, name, image) {
//   return 
// }

// listScreen(
//                             context, obj.name?[index], obj.image?[index]);