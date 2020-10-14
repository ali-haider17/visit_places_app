import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import './providers/place_provider.dart';

import './screens/places_list.dart';
import './screens/add_places.dart';
import './screens/place_detail.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: PlaceProvider()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme().copyWith(
            color: Color.fromRGBO(0, 74, 173, 1)
          )
        ),

        routes: {
          AddPlacesScreen.routeName: (ctx) => AddPlacesScreen(),
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        },
        home: new SplashScreen(
          seconds: 5,
          navigateAfterSeconds: new PlacesListScreen(),

          title: new Text('Visit Places',
            style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0
            ),),
          loadingText: Text("Loading...", style: TextStyle(color: Colors.white, fontSize: 18),),
          image: new Image.asset("assets/images/visit.png"),
          backgroundColor: Color.fromRGBO(0, 74, 173, 1),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 200.0,
          loaderColor: Colors.amber,
        )
      ),
    );
  }
}
