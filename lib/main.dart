import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() async {
  await getGps();
  runApp(const MyApp());
}

const String textfile = """
41.79544722222222,140.75535555555555
41.79555555555555,140.75529444444444
41.79823333333333,140.75615
41.798183333333334,140.7561638888889
41.79606944444444,140.75689722222222
41.796825,140.75599722222222
41.79550277777778,140.75474444444444
41.79544444444444,140.75534166666668
41.796825,140.75599722222222
41.79609722222222,140.75689722222222
41.79815277777777,140.75680555555556
41.79788333333333,140.75534166666668
41.79546111111111,140.75534166666668
41.79582222222222,140.75659166666668
41.79575,140.75435
41.795775,140.75433333333334
41.79662222222222,140.75627222222224
41.797888888888885,140.75534166666668
41.79510555555555,140.7553111111111
41.79506666666666,140.7553111111111
41.795494444444444,140.75473055555557
41.798141666666666,140.75681944444443
41.796619444444445,140.75625555555555
41.79558888888889,140.75537222222223
41.79546111111111,140.75534166666668
41.79582222222222,140.75657777777778
41.79558888888889,140.7565
41.79559722222222,140.75651666666667
""";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MapWidget(),
    );
  }
}

List<LatLng> gps = [];
Future<void> getGps() async {
  // print(str);

  // print("getgps");
  // final file = File('/Users/takuto/Code/image_gps_plot_on_map/gps');
  var lines = textfile.split('\n');

  for (int i = 0; i < lines.length - 1; i++) {
    var splited = lines[i].split(',');
    gps.add(LatLng(double.parse(splited[0]), double.parse(splited[1])));
  }

  // print(gpsCoordinates.length);
  // return gpsCoordinates;
}

class MapWidget extends StatelessWidget {
  MapWidget({super.key});
  List<Marker> markers = [];
  List<Polyline> polylines = [
    Polyline(points: [gps[15], gps[14], gps[20], gps[0], gps[26], gps[25]], strokeWidth: 7, color: Colors.black)
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < gps.length; i++) {
      var element = gps[i];
      markers.add(Marker(
          point: element,
          height: 140,
          width: 140,
          child: Column(
            children: [
              Text(
                i.toString(),
                style: const TextStyle(fontSize: 13),
              ),
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 30,
              ),
            ],
          )));
    }
    return FlutterMap(
      options: const MapOptions(
        // 名古屋駅の緯度経度です。
        initialCenter: LatLng(41.79544722222222, 140.75535555555555),
        initialZoom: 16.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: markers,
        ),
        PolylineLayer(polylines: polylines)
      ],
    );
  }
}
