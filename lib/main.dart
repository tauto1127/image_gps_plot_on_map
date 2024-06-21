import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const MapWidget(),
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        // 名古屋駅の緯度経度です。
        initialCenter: LatLng(35.170915, 136.881537),
        initialZoom: 10.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        const MarkerLayer(
          markers: [
            Marker(
              width: 30.0,
              height: 30.0,
              // ピンの位置を設定
              point: LatLng(41.79575, 140.75435),
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                // ここでピンのサイズを調整
                size: 50,
              ),
              // マップを回転させた時にピンも回転するのが rotate: false,
              // マップを回転させた時にピンは常に同じ向きなのが rotate: true,
              rotate: true,
            ),
          ],
        ),
      ],
    );
  }
}
