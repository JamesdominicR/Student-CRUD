import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_operations/assets/data_model.dart';

class UpdateScreen extends StatefulWidget {
  String name, place, phone, image;
  int? ind;
  UpdateScreen({
    Key? key,
    required this.ind,
    required this.name,
    required this.place,
    required this.phone,
    required this.image,
  }) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
//Accessing Gallery and Camera
  String? imageok;
  Future pickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      var imageTemporary = image.path;
      setState(() => imageok = imageTemporary);
    }
  }

  Future getImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = image.path;
    setState(() => imageok = imageTemporary);
  }

  final _nameController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? name2 = widget.name;
    String? img2 = widget.image;
    String? place2 = widget.place;
    String? number2 = widget.phone;
    ListItem? obj = ListItem();
    String? nam1 = obj.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  imageok != null
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(File(imageok!)),
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: const Text('Choose Image From'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      pickImage();
                                      Navigator.pop(context, 'Gallery');
                                    },
                                    child: const Text('Gallery'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      getImage();
                                      Navigator.pop(context, 'Camera');
                                    },
                                    child: const Text('Camera'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(File(img2)),
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: const Text('Choose Image From'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      pickImage();
                                      Navigator.pop(context, 'Gallery');
                                    },
                                    child: const Text('Gallery'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      getImage();
                                      Navigator.pop(context, 'Camera');
                                    },
                                    child: const Text('Camera'),
                                  ),
                                ],
                              ),
                            ),
                          )),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    initialValue: name2,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter some text';
                      }
                      name2 = value;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      initialValue: place2,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Place'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter some text';
                        }
                        place2 = value;
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      initialValue: number2,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Phone No'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter some text';
                        }
                        number2 = value;
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final box = Hive.box<ListItem>('listitems');

                          box.putAt(
                              widget.ind!,
                              ListItem(
                                  name: name2,
                                  place: place2,
                                  phone: number2,
                                  image: imageok!));
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(500, 50),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
