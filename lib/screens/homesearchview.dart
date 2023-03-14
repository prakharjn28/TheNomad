/*
* author: Giao U
* Page: this create a searching view page to search for location
* */

/*date: March 11th 2023
new changes: Add search bar,
show list
searching activity

*/

import 'package:TheNomad/models/destination_model.dart';
import 'package:flutter/material.dart';
import 'package:TheNomad/screens/details.dart';
import 'package:go_router/go_router.dart';
import 'package:TheNomad/provider/destinationProvider.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  List<Destination> _places = DestinationProvider.places;
  List<Destination> _favoritePlaces = DestinationProvider.getHighRatingPlaces();

  void _runFilter(String keyword) {
    List<Destination> results = [];
    if (keyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _places;
    } else {
      results = _places
          .where(
              (user) => user.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      _places = results;
      if (_places.isNotEmpty) {
        print(_places[0].name);
      } else {
        print("No place found!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://www.washingtonpost.com/rf/image_1484w/2010-2019/WashingtonPost/2017/06/07/Production/Sunday/Travel/Graphics/road%20trip0611.jpg?t=20170517",
              width: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://img.freepik.com/free-vector/location_53876-25530.jpg?w=740&t=st=1678592153~exp=1678592753~hmac=2976d5159c79eda45487ad684abdbeff46cc66edd3322e076216815a7bfc149b",
                  width: 20,
                ),
                const SizedBox(
                  width: 2,
                ),
                const Text(
                  'Seattle',
                  style: TextStyle(color: Color(0xff8f294f), fontSize: 16.0),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.network(
                "https://cdn.dribbble.com/users/3080947/screenshots/5938502/seattle_icon-01_4x.png",
                width: 55,
                height: 55,
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                // ignore: sort_child_properties_last
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/search.png",
                        width: 24,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) => _runFilter(value),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Places'),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              _favoritePlaces.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'High Rating',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'View All',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff8f294f)),
                        ),
                      ],
                    )
                  : Text(""),
              _favoritePlaces.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: size.height * .4,
                      child: ListView.builder(
                          itemCount: _favoritePlaces.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  context.push(
                                      "/locationDetails?states=${_favoritePlaces[index].id}");
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        child: Image.network(
                                            _favoritePlaces[index].imageUrl)),
                                    Positioned(
                                      bottom: 20,
                                      left: 20,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, .5),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/star.png",
                                              width: 30,
                                            ),
                                            Text(
                                              _favoritePlaces[index]
                                                  .rating
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  : Text(""),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Discover Places',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff8f294f)),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                height: size.height * .4,
                child: ListView.builder(
                    itemCount: _places.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: GestureDetector(
                          onTap: () {
                            context.push('/locationDetails?states=$index');
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Image.network(
                                  _places[index].imageUrl,
                                  fit: BoxFit.fill,
                                  height: 60.0,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _places[index].name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _places[index].shortLocation,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Color(0xff686771),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/star.png",
                                              width: 30,
                                            ),
                                            Text(
                                              _places[index].rating.toString(),
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}












//old version

/*import 'package:flutter/material.dart';
import 'package:TheNomad/screens/search_delegate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key, required this.title});

  final String title;

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  late GoogleMapController mapController;

  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  final Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    mapController = _cntlr;
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 17),
        ),
      );
    });
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            openMap(47.60927774403892, -122.31786795972072);
          },
          child: SizedBox(
            height: 200,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
          ),
        ),
      ),
    );
  }
}*/


