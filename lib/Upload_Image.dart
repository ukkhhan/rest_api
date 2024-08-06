import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _imagePicker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickerFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (pickerFile != null) {
      image = File(pickerFile.path);
      setState(() {});
    } else {
      print('please select your image');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest('POST', uri);

    request.fields['title' 'price'] = 'Static Title' '200';

    var mutipart = new http.MultipartFile('image', stream, length);

    request.files.add(mutipart);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("Successfully Uploaded");
    } else {
      setState(() {
        showSpinner = false;
      });
      print('Failed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Image Picker',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  child: image == null
                      ? Center(
                          child: Text('Choose Image'),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path).absolute,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                  onTap: () {
                    uploadImage();
                  },
                  child: Container(
                    child: Center(child: Text('Upload')),
                    height: 50,
                    color: Colors.green,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
