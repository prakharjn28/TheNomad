import 'package:flutter/cupertino.dart';
import 'package:TheNomad/models/destination_model.dart';

class DestinationProvider extends ChangeNotifier {
  static final List<Destination> places = [
    Destination(
        0,
        "Seattle Aquarium",
        "Down at the Seattle Aquarium on the waterfront’s Pier 59, learn all about salmon, meet a few adorable sea otters, and greet the various sea creatures of the Pacific Ocean, from puffers to giant clams. Watch scuba divers feed the fish, gawk at sharks swimming overhead in the underwater dome, and even touch a sea anemone.",
        "Pier 59",
        "1483 Alaskan Way, Pier 59, Seattle, WA 98101",
        4.4,
        "https://images.seattletimes.com/wp-content/uploads/2019/12/12062019_aquarium_130748.jpg?d=1560x1067",
        47.607512297636994,
        -122.34294507301328),
    Destination(
        1,
        "Space Needle",
        "Built for the 1962 World’s Fair, the 605-foot-tall Space Needle quickly became an icon of the city that today is recognized far and wide. On the observation level, which you can reach via a 43-second elevator ride, see the doodle-on-a-napkin concept that led to the Space Needle design. Views from the top feature Elliott Bay, the Cascade Mountains, and even Mount Rainier.",
        "Seattle Center",
        "2901 3rd Ave, Seattle, WA 98109",
        4.6,
        "https://uploads.visitseattle.org/2018/01/22063542/T2Do_SpaceNeedle2_DavidNewman-768x576.jpg",
        47.62067622253376,
        -122.34926667301272),
    Destination(
        2,
        "Museum of Pop Culture (MoPOP)",
        "Music, science fiction, and pop culture all come together at the fascinating Museum of Pop Culture. The Frank Gehry-designed building looks like a smashed guitar from above, while inside, its colorful exhibits cover everything from the history of indie video games and horror films to Nirvana, the Seahawks, and more.",
        "Seattle Center",
        " 325 Fifth Ave N, Seattle, WA 98109",
        4.6,
        "https://uploads.visitseattle.org/2015/02/01044230/Star.Wars_.EMP_Brady.Harvey.jpg",
        47.62067622253376,
        -122.34926667301272),
    Destination(
        3,
        "Pike Place Market",
        "From the iconic market sign and Rachel the Piggy Bank to the gum wall, the original Starbucks cafe, well over 225 local artisans selling their wares, the famous fish-tossing tradition, and music-playing street performers, there are enough sights and sounds at Pike Place Market to pack a day (or more). The market added its historic MarketFront expansion in 2017, featuring an open-air plaza and fantastic views of Elliott Bay.",
        "Downtown Seattle",
        "85 Pike St, Ste 500, Seattle, WA 98101",
        4.3,
        "https://uploads.visitseattle.org/2018/01/22063525/T2Do_PikePlaceMarket_TiffanyVonArnim-768x424.jpg",
        47.62067622253376,
        -122.34926667301272),
  ];

  //get places that are popular and liked the most.
  static List<Destination> getHighRatingPlaces() {
    return places.where((element) => element.rating >= 4.6).toList();
  }

  //get places that are searched
  static List<Destination> getSelectedPlace(String place) {
    return places
        .where((element) =>
            element.name.toLowerCase().contains(place.toLowerCase()))
        .toList();
  }
}
