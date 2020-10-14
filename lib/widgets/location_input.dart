import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location.dart' as location;

import '../screens/maps.dart';

class LocationInput extends StatefulWidget {

  //TODO: STORING LOCATION IN SQLITE
  //Todo: 2.3. Fetching the method

  final Function selectPlace;
  LocationInput(this.selectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String imageUrl;

  //TODO: PREVIEWING THE MAP SNAPSHOT
  //Todo: 1. Defining a function to show a preview of map

  void showMapPreview(double latitude, double longitude) {

    final staticMapUrl = location.Location.generateLocationImage(
        longitude: latitude,
        latitude: longitude
    );

    setState(() {
      imageUrl = staticMapUrl;
    });
  }

  //Todo: Method to get current user location
  Future<void> getCurrentUserLocation() async {
    //Todo: Using getLocation method to get coordinates

    try{
      final locationCoordinates = await Location().getLocation();
//    print(locationCoordinates.latitude);
//    print(locationCoordinates.longitude);

      //TODO: PREVIEWING THE MAP SNAPSHOT
      //Todo: 2. Calling method to show a preview of map
      showMapPreview(locationCoordinates.latitude, locationCoordinates.longitude);
      widget.selectPlace(locationCoordinates.latitude, locationCoordinates.longitude);
    }

    catch(error){
      return;
    }


//  //Todo: Calling the generateLocationImage method
//    final staticMapUrl = location.Location.generateLocationImage(
//        longitude: locationCoordinates.latitude,
//        latitude: locationCoordinates.longitude
//    );
//
//    setState(() {
//      imageUrl = staticMapUrl;
//    });
//
//
//    //TODO: STORING LOCATION IN SQLITE
//    //Todo: 2.3. Forwarding the coordinated to the method
//    widget.selectPlace(locationCoordinates.latitude, locationCoordinates.longitude);
  }

  //Todo: Method to display the map
  Future<void> selectMap() async {

    //TODO: PICK A LOCATION IN MAPS
    //Todo: 5. Receiving coordinates sent back using pop method
    //Todo: Need to specify the type of object to return (i-e LatLng)

    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(

        //Todo: Using fullscreenDialog argument which provides an open animation and
        //todo: a cross button instead of a back one.
        fullscreenDialog: true,
        builder: (context){
          return MapsScreen(isSelected: true,);
      })
    );

    if(selectedLocation == null)
      {
        return;
      }

    //TODO: PREVIEWING THE MAP SNAPSHOT
    //Todo: 3. Calling method to show a preview of map
    showMapPreview(selectedLocation.latitude, selectedLocation.longitude);

    //TODO: STORING LOCATION IN SQLITE
    //Todo: 2.4. Forwarding the coordinated to the method
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: imageUrl == null ? Text("No Location Found!")
                : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
            )
        ),

        Row(
          children: <Widget>[
            FlatButton.icon(
                onPressed: (){
                  getCurrentUserLocation();
                },
                icon: Icon(Icons.location_on),
                label: Text("Current Location")),

            FlatButton.icon(
                onPressed: (){
                  selectMap();
                },
                icon: Icon(Icons.map),
                label: Text("Select on Map")),
          ],
        )
      ],
    );
  }
}
