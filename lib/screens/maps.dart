import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapsScreen extends StatefulWidget {

  //todo: Defining an initialLocation variable of type PlaceLocation
  //todo: to get the initial location
  final PlaceLocation initialLocation;
  final bool isSelected;

  //todo: Setting some default values
  MapsScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 67.3534185,
      longtitude: 24.8660597,
    ),
    this.isSelected = false
  });

  @override
  _MapsScreenState createState() => _MapsScreenState();
}


//TODO: DISPLAYING A MAP WITHOUT A MARKER
class _MapsScreenState extends State<MapsScreen> {

  //TODO: PICK A LOCATION IN MAPS
  //Todo: 2. Defining a method to fetch and store the picked location
  LatLng selectedPostion;

  //Todo: Here getting the position on Tap automatically
  void selectLocationOnMap(LatLng position){
    setState(() {
      selectedPostion = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        actions: <Widget>[

          //TODO: PICK A LOCATION IN MAPS
          //Todo: 4. Adding a Checkmark to save the location by sending back the
          //todo: the coordinates when popping
          if(widget.isSelected)
            IconButton(
            icon: Icon(Icons.check),
            onPressed: selectedPostion == null ? null : (){
              Navigator.of(context).pop(
                selectedPostion
              );
            },
          )

        ],
      ),


      //Todo: Using a GoogleMap Widget
      body: GoogleMap(
          //todo: initialCameraPosition defines the location focused when app launches.
        //todo: takes the CameraPosition Widget which requires the argument target
          initialCameraPosition: CameraPosition(
            //todo: target takes LatLng class to take map coordinates
              target: LatLng(25.69893, 32.6421),

            zoom: 16,
          ),

            //TODO: PICK A LOCATION IN MAPS
            //Todo: 1. Adding an onTap listener to GoogleMap

           onTap: widget.isSelected ? selectLocationOnMap : null,

        //TODO: PICK A LOCATION IN MAPS
        //Todo: 3. Adding/Setting a marker to GoogleMap

        //TODO: ADDING PLACE DETAIL SCREEN
        //Todo: To show a marker when not selecting

        markers: (selectedPostion == null && widget.isSelected) ? null
          //TODO: Creating a Set
          //Todo: A set is created similarly like a Map but instead of having
          //todo: key-value pairs, a set only has values
          //todo: Each value in a set is unique, no to same values

          //Todo: Creating a Set of Markers using Marker class object
          //Todo: Each Marker() takes two main arguments: markerID (needs to have a unique ID)
          //todo: and position which takes coordinated
            : {
                Marker(
                  markerId: MarkerId('map1'),
                  position: selectedPostion ??
                      //Todo: Creating a location for marker if selectedlocation is null
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longtitude
                      )
                ),
              },
      ),
    );
  }
}

