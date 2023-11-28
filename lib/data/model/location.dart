class Location {
  final double lat;
  final double lon;

  const Location({required this.lat, required this.lon});
}

class MoscowLocation extends Location {
 const MoscowLocation({
   super.lat = 55.7522200,
   super.lon = 37.6155600,
 });
}