import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mapbox_test/route.dart';

String accessToken = '';
Future main() async {
  await dotenv.load(fileName: ".env");
  accessToken = dotenv.env['ACCESS_TOKEN'] ?? "";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;
  final Point origin = Point(
      coordinates:
          Position(85.338512, 27.671152)); // Example origin (San Francisco)

  @override
  void initState() {
    super.initState();
    MapboxOptions.setAccessToken(
        accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox Navigation'),
      ),
      body: MapWidget(
        key: const ValueKey('mapWidget'),
        cameraOptions: CameraOptions(zoom: 16, center: origin),
        onMapCreated: _onMapCreated,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNaviagtion,
        child: const Icon(Icons.directions),
      ),
    );
  }

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }

  _createNaviagtion() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AnimatedRoute()));
  }
}
