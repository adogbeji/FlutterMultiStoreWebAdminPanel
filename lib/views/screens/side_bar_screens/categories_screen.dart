import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

import 'package:file_picker/file_picker.dart';

class CategoriesScreen extends StatefulWidget {
  // const CategoriesScreen({super.key});
  static const String routeName = '\CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key

  dynamic _image; // Global variable to store picked image

  String? fileName; // Stores name of picked file

  // FUNCTION TO PICK IMAGES
  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, type: FileType.image); // Stores picked image

    if (result != null) {
      setState(() {
        _image =
            result.files.first.bytes; // Assigns picked image to _image (above)

        fileName = result.files.first
            .name; // Assigns name of picked image to fileName (above)
      });
    }
  }

  uploadCategory() {
    if (_formKey.currentState!.validate()) {
      print('Valid!');
    } else {
      print('Not Valid!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          border: Border.all(
                            color: Colors.grey.shade800,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image != null
                            ? Image.memory(
                                _image,
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Text('Category'),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.yellow.shade900,
                        ),
                        child: const Text('Upload Image'),
                      ),
                    ],
                  ),
                ),

                // SEARCH BAR
                Flexible(
                  child: SizedBox(
                    width: 320,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Category Name Must Not Be Empty!';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Category Name',
                        hintText: 'Enter Category Name',
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 30,
                ),

                ElevatedButton(
                  onPressed: () {
                    uploadCategory();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.yellow.shade900,
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
