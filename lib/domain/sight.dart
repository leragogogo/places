enum Categories { hotel, restaurant, specialPlace, park, museum, cafe }

class Sight{
  
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final Categories type;

  Sight(this.name,this.lat,this.lon,this.url,this.details,this.type);
}