import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_places.dart';
import './place_detail.dart';

import '../providers/place_provider.dart';

class PlacesListScreen extends StatelessWidget {

  void addPlace(BuildContext context){
    Navigator.of(context).pushNamed(
      AddPlacesScreen.routeName
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visit Places"),
        backgroundColor: Theme.of(context).appBarTheme.color,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              addPlace(context);
            },
          )
        ],
      ),



      body: FutureBuilder(
            future: Provider.of<PlaceProvider>(context, listen: false).fetchDataPlaces(),
            builder: (ctx, data) {
              //TODO: Displaying the Places
              return data.connectionState == ConnectionState.waiting ?
              Center(
                child: CircularProgressIndicator(),
              )

                  : Consumer<PlaceProvider>(

                builder: (ctx, placeData, child) {
                  return placeData.places.length <= 0 ?
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/nothing.png"),
                        SizedBox(
                          height: 30,
                        ),
                        Text("No places added yet!", style: TextStyle(fontSize: 18, color: Colors.red),),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            //Todo: Using FileImage widget to get and display the image file stored on the device
                            backgroundImage: FileImage(
                                placeData.places[index].image),
                          ),

                          title: Text(placeData.places[index].title),

                          //TODO: STORING LOCATION IN SQLITE
                          //Todo: 2.13 Displaying all the data stored in the database
                          subtitle: Text(placeData.places[index].location.address),

                          onTap: () {
                            //TODO: ADDING PLACE DETAIL SCREEN
                            //Todo: Navigating to place details screen
                            Navigator.of(context).pushNamed(
                              PlaceDetailsScreen.routeName,
                              arguments: placeData.places[index].id,
                            );
                          },

                        ),
                      );
                    },
                    itemCount: placeData.places.length,

                  );
                },
              );
            }
      )
    );
  }
}
