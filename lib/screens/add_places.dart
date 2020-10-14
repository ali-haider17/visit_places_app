import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../widgets/input_image.dart';
import '../widgets/location_input.dart';
import '../providers/place_provider.dart';
import '../models/place.dart';


class AddPlacesScreen extends StatefulWidget {

  static const routeName = "/add_place_screen";

  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {

  //TODO: STORING LOCATION IN SQLITE
  //Todo: 2.5. Defining a new PlaceLocation to store data
  PlaceLocation selectedLocation;

  final titleController = TextEditingController();

  // TODO: 1. Managing and Storing the image
  File storeImage;

  //Todo: Creating a function to store the selected/picked image
  void getPickedImage(File selectedImage){
    storeImage = selectedImage;
  }


  //TODO: STORING LOCATION IN SQLITE
  //Todo: 2.1. Defining a new method to fetch coordinates
  void selectPlace(double latitude, double longitude){

    //Todo: 2.6. Setting PlaceLocation to store data
    selectedLocation = PlaceLocation(
      latitude: latitude,
      longtitude: longitude
    );
  }

  //Todo: Method to store a new place when submitting the data
  void addNewPlace(){
    if(titleController.text.isEmpty || storeImage == null || selectedLocation == null)
      return;

    //TODO: STORING LOCATION IN SQLITE
    //Todo: 2.7 Forwarding the PlaceLocation (selectedLocation)
    Provider.of<PlaceProvider>(context, listen: false).addNewPlace(titleController.text, storeImage, selectedLocation);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Place"),

      ),

      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                      controller: titleController,

                    ),

                    SizedBox(
                    height: 10,
                    ),

                    InputImage(getPickedImage),

                    SizedBox(height: 10,),


                    //TODO: STORING LOCATION IN SQLITE
                    //Todo: 2.2. Passing the method to fetch coordinates
                    LocationInput(selectPlace),

                  ],
                ),
              ),
            )
          ),

          //TODO: Using the special RaisedButton.icon constructor
          //todo: which gives a RaisedButton containing both a label and an icon.

          RaisedButton.icon(
            onPressed: (){
                addNewPlace();
                Navigator.of(context).pop();
            },

            //Todo: Setting elevation to 0 to drop the shadow
            elevation: 0,
            //Todo: This ensures that have a big space to hit with the finger by
            //todo: shrinking it and getting rid of extra margin around te bbutton
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            icon: Icon(Icons.add),
            label: Text("Add a place"),
          ),



        ],
      )
    );
  }
}
