enum Categories {
  hotel('Отель'),
  restaurant('Ресторан'),
  specialPlace('Особое место'),
  park('Парк'),
  museum('Музей'),
  cafe('Кафе');

  const Categories(this.message);
  final String message;
}

class Sight {
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final Categories type;

  Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
  });
}
