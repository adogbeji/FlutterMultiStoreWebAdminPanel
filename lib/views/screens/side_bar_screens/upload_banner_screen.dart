import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

class UploadBannerScreen extends StatefulWidget {
  // const UploadBannerScreen({super.key});
  static const String routeName = '\UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;  // Stores firebase_storage package
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  // Stores cloud_firestore package

  dynamic _image;  // Global variable to store picked image

  String? fileName;  // Stores name of picked file
  
  // FUNCTION TO PICK IMAGES
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, type: FileType.image); // Stores picked image

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;  // Assigns picked image to _image (above)

        fileName = result.files.first.name;  // Assigns name of picked image to fileName (above)
      });
    }
  }

  // FUNCTION TO UPLOAD IMAGE TO FIREBASE STORAGE
  _uploadBannersToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);  // Stores result of creating folder to store banner images 
    
    UploadTask uploadTask = ref.putData(image);  // Stores result of uploading image to Firebase Storage
  
    TaskSnapshot snapshot = await uploadTask;  // Stores result of uploaded image
    String downloadURL = await snapshot.ref.getDownloadURL();  // Stores image download URL
    return downloadURL;
  }
  
  // FUNCTION TO STORE BANNER IMAGES IN FIRESTORE DATABASE
  uploadToFireStore() async {
    if (_image != null) {  // Function called if user has picked an image
      String imageURL = await _uploadBannersToStorage(_image); // Stores image URL
    
      await _firestore.collection('banners').doc(fileName).set({
        'image': imageURL,
      });  // Stores images in 'banners' collection
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
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
                              child: Text('Banner'),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pickImage();
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
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  uploadToFireStore();
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
    );
  }
}
