import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyCamera extends StatefulWidget {
  @override
  _MyCameraState createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  File imagepath;
  var imageurl;
  var furl;
  var fs = FirebaseFirestore.instance;
  myclick() async {
    var pick = ImagePicker();
    var image = await pick.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imagepath = File(image.path);
    });
    print('click');

    var fstorage =
        FirebaseStorage.instance.ref().child("myimages").child("my.jpg");
    print(fstorage);
    fstorage.putFile(imagepath);
    imageurl = await fstorage.getDownloadURL();
    print(imageurl);
    setState(() {
      furl = imageurl;
    });
    await fs.collection("image").add({
      "imageurl": furl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.camera),
        title: Text('Camera'),
        actions: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: furl == null
                ? NetworkImage(
                    'https://pp.netclipart.com/pp/s/27-271235_clipart-of-human-face-and-happy-animated-picture.png')
                : NetworkImage(furl),
          ),
        ],
      ),
      body: Container(
        width: 300,
        height: 300,
        color: Colors.amber,
        child: imagepath == null
            ? Center(child: Text('No image'))
            : Center(child: Image.file(imagepath)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myclick();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
