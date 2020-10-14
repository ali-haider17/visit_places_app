import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/maps.dart';

import '../providers/place_provider.dart';

//TODO: ADDING PLACE DETAIL SCREEN
//Todo: 1.1. Creating a widget to display detail
class PlaceDetailsScreen extends StatelessWidget {

  static const routeName = "/place_details";

  @override
  Widget build(BuildContext context) {

    //Todo: 1.2. Fetching the specific id of place
    final id = ModalRoute.of(context).settings.arguments;

    //Todo: 1.3. Fetching the details of place w.r.t
    final selectedPlace = Provider.of<PlaceProvider>(context,listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),

      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(selectedPlace.image, fit: BoxFit.cover, width: double.infinity,)
          ),

          SizedBox(height: 10,),

          Text(selectedPlace.location.address, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.grey),),

          SizedBox(height: 10,),

          FlatButton(
              onPressed: (){

                //Todo: 1.3. Displaying the map
                Navigator.of(context).push(
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx){
                    return MapsScreen(initialLocation: selectedPlace.location,);
                  })
                );

              },
              child: Text("View Map"),
          )
        ],
      ),
    );
  }
}
