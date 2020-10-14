import 'package:flutter/material.dart';
import 'dart:io';

//Todo: As a location can have georgraphical coordinates and address
//Todo: Defining a class to be assigned as a data type
class PlaceLocation {
  final double latitude;
  final double longtitude;
  final String address;

  const PlaceLocation({
    this.latitude,
    this.longtitude,
    this.address
  });
}

class Place{
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    this.id,
    this.title,
    this.location,
    this.image
  });

}