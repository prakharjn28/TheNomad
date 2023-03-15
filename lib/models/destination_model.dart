class Destination {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final double latitude;
  final double longitude;

  Destination(this.id, this.name, this.description, this.images, this.latitude,
      this.longitude);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return 'Destination{id: $id, name: $name, description: $description, images: $images, latitude: $latitude, longitude: $longitude}';
  }
}
