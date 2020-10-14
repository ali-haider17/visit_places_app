import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:path/path.dart' as p;

import 'dart:io';

class InputImage extends StatefulWidget {

  //TODO: 3. Managing and Storing the image
  //Todo: Defining a function
  Function pickedImage;
  InputImage(this.pickedImage);

  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {

  File storedImage;

  //Todo: Method to take picture
  Future<void> takePicture() async{
    //Todo: Using ImagePicker.pickImage which is a static method returning a
    //todo: future
    //todo: pickImage method takes a source argument to specify the source for the
    //todo: image, there are two sources, can use ImageSource
    //todo: (as ImageSource.camera to use the camera or ImageSource.gallery to take
    //todo: an image)

    final imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera,

        //Todo: restricting the size of te image
        maxHeight: 600
    );

    if(imageFile == null){
      return;
    }

    setState(() {
      storedImage = imageFile;
    });

    //TODO: Finding out the path
    //Todo: Need to access the applications documents directory, which is found
    //todo: on the device, reserved for app data.
    //todo: Using the getApplicationDocumentsDirectory( ) which returns a future

    final appDirectory = await path.getApplicationDocumentsDirectory();

    //Todo: Using path package to construct a new path
    //Todo: Using basename method which gives part of a path, need to get the file name
    //todo: imageFile.path refers to the path where the image is stored (temporary
    //todo: directory) which includes the folders as well as the file name.
    final fileName = p.basename(imageFile.path);

    //Todo: Calling a copy method to copy the file into another location/storage
    //todo: takes the path where the file should be copied to
    //todo: Here, fetching the path property from appDirectory
    final saveImageFile = await imageFile.copy("${appDirectory.path}/$fileName");

    // TODO: 4. Managing and Storing the image
    //Todo: Passing back the file
    widget.pickedImage(saveImageFile);

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          //Todo: Displaying the image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              )
            ),

            //TODO: Using Image.file() which allow to create an image based on
            //todo: file on the device
            child: storedImage != null ?
              Image.file(
                storedImage,
                fit: BoxFit.cover,
                width: double.infinity,
                )
                : Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("No Image Found", textAlign: TextAlign.center,)
                ),
          ),

          FlatButton.icon(
              onPressed: (){
                takePicture();
              },

              icon: Icon(Icons.camera),
              label: const Text("Take a picture!")
          )
        ],
      ),
    );
  }
}
