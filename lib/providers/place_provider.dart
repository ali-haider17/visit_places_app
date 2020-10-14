import 'package:flutter/material.dart';
import 'dart:io';

import '../models/place.dart';
import '../helpers/sqlite_database.dart';
import '../helpers/location.dart' as location;

class PlaceProvider with ChangeNotifier{

  List<Place> _places = [];

  List<Place> get places{
    return [..._places];
  }


  //TODO: ADDING PLACE DETAIL SCREEN
  //Todo: 2. Adding a new method to get the place item by id
  Place findById(String id){
    return _places.firstWhere((place){
      return place.id == id;
    });
  }

  // TODO: 2. Managing and Storing the image
  Future<void> addNewPlace(String imageTitle, File imageFile, PlaceLocation selectedLocation) async{

    //TODO: STORING LOCATION IN SQLITE
    //Todo: 2.8 Getting the Address using the coordinates
    final getAddress = await location.Location.getCoordinatesAddress(selectedLocation.latitude, selectedLocation.longtitude);

    //TODO: STORING LOCATION IN SQLITE
    //Todo: 2.9 Creating a new PlaceLocation with address
    final updatedLocation = PlaceLocation(
      latitude: selectedLocation.latitude,
      longtitude: selectedLocation.longtitude,
      address: getAddress
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: imageTitle,
      image: imageFile,
      location: updatedLocation
    );

    _places.add(newPlace);
    notifyListeners();

    //Todo: Inserting data into the Database
    SqlDatabase.insert('user_places', {
      'id' : newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,

      //TODO: STORING LOCATION IN SQLITE
      //Todo: 2.11 Storing the location into the database
      'latitude': newPlace.location.latitude,
      'longitude' : newPlace.location.longtitude,
      'address' : newPlace.location.address
    });

  }

  //Todo: Method to Fetch data from the database
  Future<void> fetchDataPlaces() async {
    final placeList = await SqlDatabase.getData('user_places');
    _places = placeList.map((place) {

      return Place(
          id: place['id'],
          title: place['title'],

          //Todo: Creating a new file for the path, to load that file into memory
          image: File(place['image']),

          //TODO: STORING LOCATION IN SQLITE
          //Todo: 2.12 Fetching location from the database
          location: PlaceLocation(
              latitude: place['latitude'],
              longtitude: place['longitude'],
              address: place['address']
            )

      );

    }).toList();
    notifyListeners();
  }

}