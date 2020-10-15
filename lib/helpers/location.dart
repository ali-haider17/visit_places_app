import 'package:http/http.dart' as http;
import 'dart:convert';


const GOOGLE_API_KEY = "YOUR GOODLE MAP API KEY HERE";

class Location {

  static String generateLocationImage({double latitude, double longitude})
  {
//    print(latitude);
//    print(longitude);
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  //TODO: STORING LOCATION IN SQLITE
  //Todo: 1. Defining a method to get Address (in human readable form)
  static Future<String> getCoordinatesAddress(double latitude, double longitude) async
  {
    //Todo: Using Reverse Geocoding
    //todo: which is the process of converting geographic coordinates
    //todo: into a human-readable address.
    final Url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY";

    final response = await http.get(Url);
    print(response.body);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
