import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoriesScreen extends StatefulWidget {
  // const CategoriesScreen({super.key});
  static const String routeName = '\CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseStorage _storage =
      FirebaseStorage.instance; // Stores firebase_storage package
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Stores cloud_firestore package
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key

  dynamic _image; // Global variable to store picked image

  String? fileName; // Stores name of picked file

  late String categoryName; // Stores entered catgeory name

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

  // FUNCTION TO UPLOAD IMAGE TO FIREBASE STORAGE
  _uploadCategoryBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('categoryImages').child(
        fileName!); // Stores result of creating folder to store category images

    UploadTask uploadTask = ref
        .putData(image); // Stores result of uploading image to Firebase Storage

    TaskSnapshot snapshot = await uploadTask; // Stores result of uploaded image
    String downloadURL =
        await snapshot.ref.getDownloadURL(); // Stores image download URL
    return downloadURL;
  }

  // FUNCTION TO STORE CATEGORY IMAGES IN FIRESTORE DATABASE
  uploadCategory() async {
    EasyLoading.show(); // Shows loading spinner
    if (_formKey.currentState!.validate()) {
      String imageURL = await _uploadCategoryBannerToStorage(
          _image); // Function called if form is valid

      await _firestore.collection('categories').doc(fileName).set({
        'image': imageURL,
        'categoryName': categoryName,
      }).whenComplete(() {
        EasyLoading
            .dismiss(); // Stops loading spinner after image has been uploaded

        setState(() {
          _image = null; // Removes image from screen after it has been uploaded

          _formKey.currentState!.reset();  // Resets input field
        });
      });
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
                      onChanged: (value) {
                        categoryName = value;
                      },
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
