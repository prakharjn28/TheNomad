import 'package:TheNomad/provider/destinationProvider.dart';
import 'package:TheNomad/widgets/maps_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationDetail extends StatefulWidget {
  const LocationDetail({super.key, required this.index});
  final String? index;

  @override
  State<LocationDetail> createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail> {
  @override
  Widget build(BuildContext context) {
    var destinationData =
        Provider.of<DestinationProvider>(context, listen: false);
    var locationData = destinationData.places[int.parse(widget.index!)];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(locationData.name),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(locationData.images[0],
                fit: BoxFit.cover, width: 1000.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                locationData.name,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                locationData.description,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MapButton(
                  location:
                      LatLng(locationData.latitude, locationData.longitude),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
