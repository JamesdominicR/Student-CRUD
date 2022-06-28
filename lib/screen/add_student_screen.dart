import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../assets/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  // File _Image;
  // void initState() {
  //   super.initState();
  // }

  // void open_camera() async {
  //   var image = await ImagePicker().getImage(source: ImageSource.camera);
  //   setState(() {
  //     _Image = image;
  //   });
  // }
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  Future getImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  final _nameController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter some text';
                      } else {
                        name = value;

                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _placeController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Place'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Phone No'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        image != null
                            ? Image.file(
                                image!,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              )
                            : ElevatedButton.icon(
                                icon: const Icon(Icons.camera_alt_outlined),
                                label: const Text('Open Camera'),
                                onPressed: () {
                                  //go to camera
                                  getImage();
                                },
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.image_outlined),
                          label: const Text('Pick Gallery'),
                          onPressed: () {
                            //go to gallery
                            pickImage();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Box<ListItem> box = Hive.box<ListItem>('listitems');

                        box.add(ListItem(
                            name: name,
                            place: _placeController.text,
                            phone: _phoneController.text,
                            image: image?.path != null ? image!.path : null));
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(500, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
